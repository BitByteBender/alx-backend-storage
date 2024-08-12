#!/usr/bin/env python3
""" Where can i learn Python? """


def schools_by_topic(mongo_collection, topic):
    """
        Retruns the list of school having a specific topic
    """
    return list(mongo_collection.find({"topic": topic}))
