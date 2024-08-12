#!/usr/bin/env python3
""" Listing all documents """


def list_all(mongo_collection):
    """
        Lists all docs in a mongoDB collection
    """
    return list(mongo_collection.find()) or []
