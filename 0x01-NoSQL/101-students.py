#!/usr/bin/env python3
""" Top students score """


def top_students(mongo_collection):
    """
        Returns all students sorted by average score
    """
    dict = [{"$project": {"name": 1, "topcis": 1, "averageScore":
                                                  {"$avg": "$topics.score"}}},
            {"$sort": {"averageScore": -1}}]

    return list(mongo_collection.aggregate(dict))
