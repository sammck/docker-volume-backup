from ..internal_types import *

import json

def print_table(name: str, table: JsonableDict):
    print(f"\n\nTable: {name}\n")
    print(json.dumps(table.data(), indent=2))

def do_test():

    page = "Buildings"
    mdtext = get_page_markdown(page)
    md = wtp.parse(mdtext)
    print("\n\nTables:\n")
    storage = md.tables[0]
    production = md.tables[1]
    market = md.tables[2]
    print_table("Storage", storage)
    print_table("Production", production)
    print_table("Market", market)
