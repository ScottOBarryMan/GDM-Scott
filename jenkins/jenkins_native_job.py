import os
import jenkins
import pandas as pd
import pandas.io.sql
import pyodbc
import xml.etree.ElementTree as ET

config_process = 'C:\\Users\\rick.GDM\\Desktop\\testing_temporal_native\\jenkins\\config_process.xml'
config_commit = 'C:\\Users\\rick.GDM\\Desktop\\testing_temporal_native\\jenkins\\config_commit.xml'
config_load = 'C:\\Users\\rick.GDM\\Desktop\\testing_temporal_native\\jenkins\\config_load.xml'
config_view = 'C:\\Users\\rick.GDM\\Desktop\\testing_temporal_native\\jenkins\\config_view.xml'
load_script_path = 'C:\\Users\\rick.GDM\\source\\repos\\Python\\loaders\\native'
native_jobs = []


def indent(elem, level=0):
    i = "\\n" + level*"  "
    if len(elem):
        if not elem.text or not elem.text.strip():
            elem.text = i + "  "
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
        for elem in elem:
            indent(elem, level+1)
        if not elem.tail or not elem.tail.strip():
            elem.tail = i
    else:
        if level and (not elem.tail or not elem.tail.strip()):
            elem.tail = i


# Load source table from SQL into a Dataframe
server_sql = 'olympus'
database = 'Native'
cnxn = pyodbc.connect(
    'DRIVER={SQL Server};SERVER=' + server_sql
    + ';DATABASE=' + database
    + ';Trusted_Connection=yes',
    unicode_results=True)
cnxn.close

sql = """SELECT  [sourceKey]
                ,[srcAuthorityName]
                ,[srcFileName]
                ,[srcTableName]
           FROM [dbo].[t_LD_Source]"""
source_files = pandas.io.sql.read_sql(sql=sql, con=cnxn)

# Connect to Jenkins server
server_jenkins = jenkins.Jenkins(
    'http://k2:9090/',
    username=r'gdm\\rick',
    # password=pswd,
    password='11550ec9b8bff7c212f57892fc8ecc9330',
    timeout=300)
user = server_jenkins.get_whoami()
version = server_jenkins.get_version()
print('Hello %s from Jenkins %s' % (user['fullName'], version))

# Create a Process Source job for each sourceKey
tree = ET.parse(config_process)
root = tree.getroot()
for row in source_files.itertuples():
    authority = row[2].upper()
    source_file = row[4].replace(f't_{row[2]}_', '')
    print(f'Native_{authority}_{source_file}_Process_Source')
    job_description = f'Native Loader | Process Source | {authority} | {source_file} | Triggers Nothing'
    command = f'''sqlcmd -E -b -S olympus -d Native -Q "EXEC proc_LD_ProcessSource @source_key = '{row[1]}'"'''
    subject = f'LOADER FAILURE: Native {authority} {source_file} (Process Source)'

    for desc in root.iter('description'):
        desc.text = job_description

    for cmd in root.iter('command'):
        cmd.text = command

    for subj in root.iter('defaultSubject'):
        subj.text = subject

    server_jenkins.create_job(
        f'Native_{authority}_{source_file}_Process_Source',
        ET.tostring(root, encoding='utf8', method='xml').decode())

    native_jobs.append(f'Native_{authority}_{source_file}_Process_Source')
    # break

# Create a Commit job for each sourceKey
tree = ET.parse(config_commit)
root = tree.getroot()
for row in source_files.itertuples():
    authority = row[2].upper()
    source_file = row[4].replace(f't_{row[2]}_', '')
    print(f'Native_{authority}_{source_file}_Source_Commit')
    job_description = f'Native Loader | Source Commit | {authority} | {source_file} | Triggers Nothing'
    command = f'''sqlcmd -E -b -S olympus -d Native -Q "EXEC proc_LD_Commit @source_key = '{row[1]}'"'''
    subject = f'LOADER FAILURE: Native {row[2]} {row[3]} (Commit)'

    for desc in root.iter('description'):
        desc.text = job_description

    for cmd in root.iter('command'):
        cmd.text = command

    for subj in root.iter('defaultSubject'):
        subj.text = subject

    server_jenkins.create_job(
        f'Native_{authority}_{source_file}_Source_Commit',
        ET.tostring(root, encoding='utf8', method='xml').decode())

    native_jobs.append(f'Native_{authority}_{source_file}_Source_Commit')
    # break

# Create a Bulk Load job for each bulk load python script
tree = ET.parse(config_load)
root = tree.getroot()
files = os.listdir(load_script_path)
load_scripts = [i for i in files if i.endswith('.py')]
for load_script in load_scripts:
    authority = load_script.split('_')[1].upper()
    source_file = '_'.join(load_script.split('_')[3:]).replace('.py', '').title()
    print(f'Native_{authority}_{source_file}_Bulk_Load')
    job_description = f'Native Loader | Bulk Loader | {authority} | {source_file} | Triggers Nothing'
    custom_workspace = f'\\\\olympus\\FileVault\\Native\\{authority}\\{source_file}\\Newfile'
    command = f'''
@echo off

ren %WORKSPACE%\Performance_Presentation %Performance_Presentation%

  If not exist %WORKSPACE%\Performance_Presentation (
  Echo Performance_Presentation file does not exist. Load terminated.
Exit 1
)

ren %WORKSPACE% %Data_Currency%

call activate base
python "%PYTHON%\loaders\native\load_aer_xlsx_performance_presentation.py" -f "\\makalu\Loaders\Native\FileVault\Performance_Presentation\%Data_Currency%\%Performance_Presentation%" -t "t_AER_Performance_Presentation"
        '''
    subject = f'LOADER FAILURE: Native {authority} {source_file} (Bulk Load)'

    for desc in root.iter('description'):
        desc.text = job_description

    for cwp in root.iter('customWorkspace'):
        cwp.text = custom_workspace

    for param_def in root.iter('project'):
        for desc in param_def.iter('description'):
            desc.text = job_description

    for param_def in root.iter('hudson.model.StringParameterDefinition'):
        for desc in param_def.iter('description'):
            desc.text = 'YYYY-MM-DD'

    for param_def in root.iter('hudson.model.FileParameterDefinition'):
        for desc in param_def.iter('description'):
            desc.text = None

    for cmd in root.iter('command'):
        cmd.text = command

    for subj in root.iter('defaultSubject'):
        subj.text = subject

    server_jenkins.create_job(
        f'Native_{authority}_{source_file}_Bulk_Load',
        ET.tostring(root, encoding='utf8', method='xml').decode())

    native_jobs.append(f'Native_{authority}_{source_file}_Bulk_Load')
    # break

# Create or update the Native Jenkins view
tree = ET.parse(config_view)
root = tree.getroot()
jobs = root.find('jobNames')
for job in native_jobs:
    # add an element to it
    new_data = ET.SubElement(jobs, 'string')
    new_data.text = f'{job}'
indent(root)
server_jenkins.create_view(
    'Native', ET.tostring(root, encoding='utf8', method='xml').decode())