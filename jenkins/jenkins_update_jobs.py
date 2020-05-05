#!/usr/bin/env python
# -*- coding: utf-8 -*-
from __future__ import absolute_import, division,\
                       unicode_literals, print_function

import sys
from lxml import etree
from collections import defaultdict


def change_parameter_description(
        config_xml_path, parameter_name, new_description):

    tree = etree.parse(config_xml_path)

    for tag in tree.findall('.//hudson.model.StringParameterDefinition'):
        name_tag = tag.find('./name')
        if not name_tag.text == parameter_name:
            continue
        description = tag.find('./description')
        description.text = new_description
    tree.write(config_xml_path)


for config_xml_path in sys.argv[1:]:
    change_parameter_description(
        config_xml_path, 'additional_requirements', 'bar')