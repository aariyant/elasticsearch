# Elasticsearch Cheatsheet

1. [Cluster APIs](#cluster-apis)
2. [Index and Document APIs](#index-and-document-apis)
3. [Search and Aggregation APIs](#search-and-aggregation-apis)
4. [Full Text Query](#full-text-query)
5. [Aggregations](#aggregations-apis)

---

# Cluster APIs
## Get info about cluster health
Syntax :
```http
GET _cluster/health
```

Example :
```shell
# Dev tools :
  GET _cluster/health
```

Expected result from elasticsearch :
```json
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 1,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 90.0
}
```
## Get info about cluster health, but indices level
Syntax :
```http
GET _cluster/health?level=indices
```

Example :
```shell
# Dev tools :
  GET _cluster/health?level=indices
```

Expected response from elasticsearch :
```json
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0,
  "indices" : {
    ".kibana_task_manager_7.17.23_001" : {
      "status" : "green",
      "number_of_shards" : 1,
      "number_of_replicas" : 0,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0
    },
    ".geoip_databases" : {
      "status" : "green",
      "number_of_shards" : 1,
      "number_of_replicas" : 0,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0
    },
    ".apm-custom-link" : {
      "status" : "green",
      "number_of_shards" : 1,
      "number_of_replicas" : 0,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0
    },
    ...
  }
}
```

## Get info about cluster health, but shards level
Syntax :
```http
GET _cluster/health?level=shards
```

Example :
```shell
# Dev tools :
  GET _cluster/health?level=shards
```

Expected response from elasticsearch :
```json
{
  "cluster_name" : "elasticsearch",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 8,
  "active_shards" : 8,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0,
  "indices" : {
    ".kibana_task_manager_7.17.23_001" : {
      "status" : "green",
      "number_of_shards" : 1,
      "number_of_replicas" : 0,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0,
      "shards" : {
        "0" : {
          "status" : "green",
          "primary_active" : true,
          "active_shards" : 1,
          "relocating_shards" : 0,
          "initializing_shards" : 0,
          "unassigned_shards" : 0
        }
      }
    },
    ".geoip_databases" : {
      "status" : "green",
      "number_of_shards" : 1,
      "number_of_replicas" : 0,
      "active_primary_shards" : 1,
      "active_shards" : 1,
      "relocating_shards" : 0,
      "initializing_shards" : 0,
      "unassigned_shards" : 0,
      "shards" : {
        "0" : {
          "status" : "green",
          "primary_active" : true,
          "active_shards" : 1,
          "relocating_shards" : 0,
          "initializing_shards" : 0,
          "unassigned_shards" : 0
        }
      }
    },
    ...
  }
}
```

## Get info about nodes in a cluster
Syntax :
```http
GET _nodes/stats
```

Example :
```shell
# Dev tools :
  GET _nodes/stats
```

Expected response from elasticsearch :
```json
{
  "_nodes" : {
    "total" : 1,
    "successful" : 1,
    "failed" : 0
  },
  "cluster_name" : "elasticsearch",
  "nodes" : {
    "SbhXLZ9zRhmQ_J8CYS5TNQ" : {
      "timestamp" : 1722756955709,
      "name" : "elasticsearch01",
      "transport_address" : "172.18.0.2:9300",
      "host" : "172.18.0.2",
      "ip" : "172.18.0.2:9300",
      "roles" : [
        "data",
        "data_cold",
        "data_content",
        "data_frozen",
        "data_hot",
        "data_warm",
        "ingest",
        "master",
        "ml",
        "remote_cluster_client",
        "transform"
      ],
      "attributes" : {...},
      "indices" : {...},
      "os" : {...},
      "process" : {...},
      "jvm" : {...},
      "thread_pool" : {...},
      "fs" : {...},
      "transport" : {...},
      "http" : {...},
      "breakers" : {...},
      "script" : {...},
      "discovery" : {...},
      "ingest" : {...},
      "adaptive_selection" : {...},
      "script_cache" : {...},
      "indexing_pressure" : {...}
    }
  }
}
```

## Get usage info about nodes in a cluster
Syntax :
```http
GET _cat/nodes?v
```

Example :
```shell
# Dev tools :
  GET _cat/nodes?v
```

Expected response from elasticsearch :
```json
ip         heap.percent ram.percent cpu load_1m load_5m load_15m node.role   master name
172.18.0.2           28          91  17    3.40    2.29     1.81 cdfhilmrstw *      elasticsearch01
```

## Get usage info about nodes in a cluster with ip address
Syntax :
```http
GET _nodes/{ip-address}
```

Example :
```shell
# Dev tools :
  GET _nodes/172.18.0.2
```

Expected response from elasticsearch :
```json
{
  "_nodes" : {...},
  "cluster_name" : "elasticsearch",
  "nodes" : {
    "zVXTUdJxR1Osiqm96TKGyg" : {
      "name" : "elasticsearch01",
      "transport_address" : "172.18.0.2:9300",
      "host" : "172.18.0.2",
      "ip" : "172.18.0.2",
      "version" : "7.17.23",
      "build_flavor" : "default",
      "build_type" : "docker",
      "build_hash" : "61d76462eecaf09ada684d1b5d319b5ff6865a83",
      "total_indexing_buffer" : 53687091,
      "roles" : [
        "data",
        "data_cold",
        "data_content",
        "data_frozen",
        "data_hot",
        "data_warm",
        "ingest",
        "master",
        "ml",
        "remote_cluster_client",
        "transform"
      ],
      "attributes" : {...},
      "settings" : {
        "cluster" : {
          "name" : "elasticsearch",
          "election" : {
            "strategy" : "supports_voting_only"
          }
        },
        "node" : {
          "attr" : {
            "transform" : {
              "node" : "true"
            },
            "xpack" : {
              "installed" : "true"
            },
            "ml" : {
              "max_jvm_size" : "536870912",
              "machine_memory" : "12457345024",
              "max_open_jobs" : "512"
            }
          },
          "name" : "elasticsearch01"
        },
        "path" : {
          "logs" : "/usr/share/elasticsearch/logs",
          "home" : "/usr/share/elasticsearch"
        },
        "discovery" : {
          "type" : "single-node"
        },
        "client" : {
          "type" : "node"
        },
        "http" : {
          "type" : {
            "default" : "netty4"
          }
        },
        "transport" : {
          "type" : {
            "default" : "netty4"
          },
          "features" : {
            "x-pack" : "true"
          }
        },
        "xpack" : {
          "security" : {
            "enabled" : "false"
          }
        },
        "network" : {
          "host" : "0.0.0.0"
        }
      },
      "os" : {
        "refresh_interval_in_millis" : 1000,
        "name" : "Linux",
        "pretty_name" : "Ubuntu 20.04.6 LTS",
        "arch" : "amd64",
        "version" : "6.8.0-40-generic",
        "available_processors" : 8,
        "allocated_processors" : 8
      },
      "process" : {...},
      "jvm" : {...},
      "thread_pool" : {...},
      "transport" : {...},
      "http" : {
        "bound_address" : [
          "[::]:9200"
        ],
        "publish_address" : "172.18.0.2:9200",
        "max_content_length_in_bytes" : 104857600
      },
      "plugins" : [ ],
      "modules" : [{...}],
      "ingest" : {...},
      "aggregations" : {...},
      }
    }
  }
}
```

---

# Index and Document APIs
## CRUD
### C - CREATE
#### Create an index
Syntax :
```http
PUT {index_name}
```

Example :
```shell
# Dev tools :
  PUT cars_data
```

Expected response from elasticsearch :
```json
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "cars_data"
}
```

#### Insert a document
1. Use method `POST` when you want elasticsearch automatically generate id for your document

   Syntax :
   ```http
   PUT {index_name}/_doc
   ```

   Example :
   ```shell
   # Dev tools :
     POST cars_data/_doc
     {
       "name": "Maruti Swift Dzire VDI",
       "year": 2014,
       "selling_price": 450000,
       "fuel": "diesel",
       "transmission": "manual",
       "engine": "1248 CC"
     }
   ```

   Expected response from elasticsearch :
   ```json
   {
     "_index" : "cars_data",
     "_type" : "_doc",
     "_id" : "IyZZHJEB0qbnkzQsafaN",
     "_version" : 1,
     "result" : "created",
     "_shards" : {
       "total" : 2,
       "successful" : 1,
       "failed" : 0
     },
     "_seq_no" : 0,
     "_primary_term" : 1
   }
   ```
2. Use method `PUT` if you want to set your document id manually

   Syntax :
   ```http
   PUT {index_name}/_doc/{document_id}
   ```
   
   Example :
   ```shell
   # Dev tools :
     PUT cars_data/_doc/1
     {
       "name": "Maruti Swift Dzire VDI",
       "year": 2018,
       "selling_price": 700000,
       "fuel": "diesel",
       "transmission": "manual",
       "engine": "1248 CC"
     }

     PUT cars_data/_doc/2
     {
      "name": "Skoda Rapid 1.5 TDI Ambition",
      "year": 2014,
      "selling_price": 370000,
      "fuel": "diesel",
      "transmission": "manual",
      "engine": "1498 CC"
     }

     PUT cars_data/_doc/3
     {
      "name": "Honda City 2017-2020 EXi",
      "year": 2006,
      "selling_price": 158000,
      "fuel": "diesel",
      "transmission": "manual",
      "engine": "1497 CC"
     }
   ```
#### _create endpoint
This endpoint will guarantees that the document is only indexed if it does not already exist. If use this endpoint and if there is already document with the same {{id}}, you will get a 409 error message.

Syntax :
```http
PUT {index_name}/_create/{document_id}
{
    "field": "value"
}
```
Example :
```shell
# Dev tools:
  PUT cars_data/_create/1
  {
    "name": "Maruti Swift Dzire VDI",
    "year": 2018,
    "selling_price": 800000,
    "fuel": "diesel",
    "transmission": "manual",
    "engine": "1248 CC"
  }
```
Expected response from elasticsearch :
```json
{
  "error" : {
    "root_cause" : [
      {
        "type" : "version_conflict_engine_exception",
        "reason" : "[1]: version conflict, document already exists (current version [1])",
        "index_uuid" : "WsWQUX9pTeuFQqhIbbcLxQ",
        "shard" : "0",
        "index" : "cars_data"
      }
    ],
    "type" : "version_conflict_engine_exception",
    "reason" : "[1]: version conflict, document already exists (current version [1])",
    "index_uuid" : "WsWQUX9pTeuFQqhIbbcLxQ",
    "shard" : "0",
    "index" : "cars_data"
  },
  "status" : 409
}
```
### R - READ
#### Read a document
Syntax : 
```http
GET {index_name}/_doc/{document_id}
```
Example :
```shell
# Dev tools :
  GET cars_data/_doc/1
```
Expected result from elasticsearch :
```json
{
  "_index" : "cars_data",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 1,
  "_seq_no" : 1,
  "_primary_term" : 1,
  "found" : true,
  "_source" : {
    "name" : "Maruti Swift Dzire VDI",
    "year" : 2018,
    "selling_price" : 700000,
    "fuel" : "diesel",
    "transmission" : "manual",
    "engine" : "1248 CC"
  }
}
```
### U - UPDATE
#### Update a document
Syntax :
```http
POST {index_name}/_update/{document_id}
{
    "doc": {
        "field1": "value",
        "field2": "value"
    }
}
```
Example :
```shell
# Dev tools :
  POST cars_data/_update/1
  {
    "doc": {
      "selling_price": 800000
    }
  }
```
Response from elasticsearch :
```json
{
  "_index" : "cars_data",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 2,
  "result" : "updated",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 4,
  "_primary_term" : 1
}
```
### D - DELETE
#### Delete a document
Syntax :
```http
DELETE {index_name}/_doc/{document_id}
```
Example :
```shell
# Dev tools :
  DELETE cars_data/_doc/1
```
Example :
```json
{
  "_index" : "cars_data",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 3,
  "result" : "deleted",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 5,
  "_primary_term" : 1
}
```

## Clone index
Before cloning an index, ensure that the index is in a healthy state. and before an index can be cloned, it must be made read-only with the command below :

Syntax : 
```http
PUT {index_name}/_settings
{
  "settings": {
    "index.blocks.write": true
  }
}
```

To clone an index, use the `_clone` API with the following command :
Syntax :
```http
POST {index_name}/_clone/{clone_index_name}
```

Example :
```shell
# Dev tools :
  POST news/_clone/news_clone
```

Expected response from elasticsearch :
```json
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "news_clone"
}
```

## Reindex index
The Elasticsearch reindex API copies data from one index to another. You can use reindex to change the index mapping, copy data to another cluster, or copy only a subset of data to another index.

Syntax : 
```http
POST _reindex
{
 "source": {
   "index": "{source-index}"
 },
 "dest": {
   "index": "{target-index}"
 }
}
```

Example : 
```shell
# Dev tools :
  POST _reindex
  {
    "source": {
      "index": "cars_data"
  },
    "dest": {
      "index": "Cars_reindex"
    }
  }
```

Expected response from elasticsearch :
```json
{
  "took" : 101,
  "timed_out" : false,
  "total" : 3,
  "updated" : 0,
  "created" : 3,
  "deleted" : 0,
  "batches" : 1,
  "version_conflicts" : 0,
  "noops" : 0,
  "retries" : {
    "bulk" : 0,
    "search" : 0
  },
  "throttled_millis" : 0,
  "requests_per_second" : -1.0,
  "throttled_until_millis" : 0,
  "failures" : [ ]
}
```

---

# Search and Aggregation APIs

__Dataset :__ [news](dataset/news.json)

## Search APIs
### Get all document from an index
Syntax :
```http
GET {index_name}/_search
```
Example :
```shell
# Dev tools :
  GET news/_search
```
Expected response from elasticsearch :

By default elasticsearch only show 10 sample search result
```json
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "4s5bMpEBLxDPEryMWhnZ",
        "_score" : 1.0,
        "_source" : {
          "date" : "2022-09-23",
          "short_description" : "Health experts said it is too early to predict whether demand would match up with the 171 million doses of the new boosters the U.S. ordered for the fall.",
          "@timestamp" : "2022-09-23T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/covid-boosters-uptake-us_n_632d719ee4b087fae6feaac9",
          "category" : "U.S. NEWS",
          "headline" : "Over 4 Million Americans Roll Up Sleeves For Omicron-Targeted COVID Boosters",
          "authors" : "Carla K. Johnson, AP"
        }
      },
      ...
      }
    ]
  }
}
```
### Get the exact total number of hits
Elasticsearch will limits the total count to 10.000 on large datasets to improve the response speed. To get the exact total number of hits, use this query.

Syntax :
```http
GET {index_name}/_search
{
  "track_total_hits: true
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "track_total_hits": true
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 209527,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [{...}]
  }
}
```
### Search data with specific field
Syntax:
```http
GET {index_name}/_search
{
  "query": {
    "match": {
      "query": "value"
    }
  },
  "size": "max-hits-number"
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "match": {
        "headline": {
          "query": "Over 4 Million Americans Roll Up Sleeves For Omicron-Targeted COVID Boosters"
        }
      }
    },
    "size": 1
  }

  # in short
  {
    "query": {
      "match": "headline: Over 4 Million Americans Roll Up Sleeves For Omicron-Targeted COVID Boosters"
    },
    "size": 1
  }
```

### Search data with specific time
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "type-of-query": {
      "field-name": {
        "gte": "lowest value of the time",
        "lte": "highest value of the time
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "range": {
        "date": {
          "gte": "2015-06-20",
          "lte": "2015-07-22"
        }
      }
    }
  }
```
Expected response from elasticsearch :

It will pull up articles published from 20 June 2015 until 22 July 2015.
```json
{
  "took" : 9,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2908,
      "relation" : "eq"
    },
    "max_score" : 1.0,
    "hits" : [{...}]
  }
}
```
### Search and count documents by category
Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "name-of-aggregations": {
      "type-of-aggregations": {
        "field": "field-name-to-be-aggregated",
        "size": "how-many-bucket-you-want-to-returned"
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "aggs": {
      "by_country": {
        "terms": {
          "field": "category",
          "size": 10
        }
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : 1.0,
    "hits" : [{...}]
  },
  "aggregations" : {
    "by_country" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 84740,
      "buckets" : [
        { "key" : "POLITICS", "doc_count" : 35602 },
        { "key" : "WELLNESS", "doc_count" : 17945 },
        { "key" : "ENTERTAINMENT", "doc_count" : 17362 },
        { "key" : "TRAVEL", "doc_count" : 9900 },
        { "key" : "STYLE & BEAUTY", "doc_count" : 9814 },
        { "key" : "PARENTING", "doc_count" : 8791 },
        { "key" : "HEALTHY LIVING", "doc_count" : 6694 },
        { "key" : "QUEER VOICES", "doc_count" : 6347 },
        { "key" : "FOOD & DRINK", "doc_count" : 6340 },
        { "key" : "BUSINESS", "doc_count" : 5992 }
      ]
    }
  }
}
```
### Combine query and aggregation
Search for the most significant terms in a category

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "match": {
      "field-name: "value"
    }
  },
  "aggregations": {
    "name-of-aggregations": {
      "significant_text": {
        "field": "field-name"
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "match": {
        "category": "WORLD NEWS"
      }
    },
    "aggregations": {
      "popular_in_world_news": {
        "significant_text": {
          "field": "headline"
        }
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 278,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 3299,
      "relation" : "eq"
    },
    "max_score" : 4.1510863,
    "hits" : [{...}]
  },
  "aggregations" : {
    "popular_in_entertainment" : {
      "doc_count" : 3299,
      "bg_count" : 209527,
      "buckets" : [
        { "key" : "korea", "doc_count" : 176, "score" : 1.1787771120442956, "bg_count" : 484 },
        { "key" : "rohingya", "doc_count" : 52, "score" : 0.8665656028986289, "bg_count" : 59 },
        { "key" : "north", "doc_count" : 204, "score" : 0.7675526546520289, "bg_count" : 966 },
        { "key" : "myanmar", "doc_count" : 52, "score" : 0.5626526405772524, "bg_count" : 90 },
        { "key" : "un", "doc_count" : 92, "score" : 0.3825629992837032, "bg_count" : 397 },
        { "key" : "saudi", "doc_count" : 75, "score" : 0.3813418754401737, "bg_count" : 268 },
        { "key" : "u.s", "doc_count" : 253, "score" : 0.3240580223247901, "bg_count" : 3075 },
        { "key" : "minister", "doc_count" : 60, "score" : 0.3198961920621473, "bg_count" : 205 },
        { "key" : "ukraine", "doc_count" : 59, "score" : 0.29822964407943553, "bg_count" : 212 },
        { "key" : "hong", "doc_count" : 42, "score" : 0.29321922737501194, "bg_count" : 111 }
      ]
    }
  }
}
```
### Increasing recall
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "match": {
      "field-name": {
        "query": "query-terms"
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "match": {
        "headline": {
          "query": "Man Injured In Nipsey Hussle Shooting Released From Jail"
        }
      }
    }
  }
```
Expected result from elasticsearch :

By default, every running query will use an `OR` logic. `OR` logic result in higher number of hits, thereby increasing recall.
```json
{
  "took" : 34,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : 60.062294,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "zs5bMpEBLxDPEryMXjRi",
        "_score" : 60.062294,
        "_source" : {
          "date" : "2019-04-21",
          "short_description" : "Kerry Lathan was arrested earlier this month and accused of violating his parole.",
          "@timestamp" : "2019-04-21T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/kerry-lathan-released-nipsey-hussle_n_5cbcb7fee4b032e7ceb9a7c6",
          "category" : "U.S. NEWS",
          "headline" : "Man Injured In Nipsey Hussle Shooting Released From Jail",
          "authors" : "Amy Russo"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "_s5bMpEBLxDPEryMXjRi",
        "_score" : 24.066095,
        "_source" : {
          "date" : "2019-04-12",
          "short_description" : "About 21,000 people, including  Beyonce, Jay-Z and Snoop Dogg, gathered at Staples Center in Los Angeles to honor the late rapper and activist.",
          "@timestamp" : "2019-04-12T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/nipsey-hussle-immortalized-memorial_n_5caffc13e4b0ffefe3ae1362",
          "category" : "U.S. NEWS",
          "headline" : "Nipsey Hussle, A Hometown Hero, Immortalized At Memorial",
          "authors" : ""
        }
      },
      ...
      }
    ]
  }
}
```
### Increasing precision
Syntax :
```http
GET enter_name_of_index_here/_search
{
  "query": {
    "match": {
      "field-name": {
        "query": "query-terms",
        "operator": "and"
      }
    }
  }
}
```
Example :
```shell
# Dev tools
  GET news/_search
  {
    "query": {
      "match": {
        "headline": {
          "query": "Man Injured In Nipsey Hussle Shooting Released From Jail",
          "operator": "and"
        }
      }
    }
  }
```
Expected response from elasticsearch :

`AND` operator will increase the precision of data search.
```json
{
  "took" : 5,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 1,
      "relation" : "eq"
    },
    "max_score" : 60.062294,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "zs5bMpEBLxDPEryMXjRi",
        "_score" : 60.062294,
        "_source" : {
          "date" : "2019-04-21",
          "short_description" : "Kerry Lathan was arrested earlier this month and accused of violating his parole.",
          "@timestamp" : "2019-04-21T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/kerry-lathan-released-nipsey-hussle_n_5cbcb7fee4b032e7ceb9a7c6",
          "category" : "U.S. NEWS",
          "headline" : "Man Injured In Nipsey Hussle Shooting Released From Jail",
          "authors" : "Amy Russo"
        }
      }
    ]
  }
}
```

### minimum_should_match
This will allows to specify the minimum number of terms a document should have to be included in the search results

Syntax :
```http
GET enter_name_of_index_here/_search
{
  "query": {
    "match": {
      "headline": {
        "query": "query-terms",
        "minimum_should_match": value
      }
    }
  }
}
```
Example : 
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "match": {
        "headline": {
          "query": "Man Injured In Nipsey Hussle Shooting Released From Jail",
          "minimum_should_match": 4
        }
      }
    }
  }
```
Expected response from elasticsearch :

With minimum_should_match parameter, we were able to finetune for precission and recall
```json
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 3,
      "relation" : "eq"
    },
    "max_score" : 60.062294,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "zs5bMpEBLxDPEryMXjRi",
        "_score" : 60.062294,
        "_source" : {
          "date" : "2019-04-21",
          "short_description" : "Kerry Lathan was arrested earlier this month and accused of violating his parole.",
          "@timestamp" : "2019-04-21T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/kerry-lathan-released-nipsey-hussle_n_5cbcb7fee4b032e7ceb9a7c6",
          "category" : "U.S. NEWS",
          "headline" : "Man Injured In Nipsey Hussle Shooting Released From Jail",
          "authors" : "Amy Russo"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "xM9bMpEBLxDPEryMf3ir",
        "_score" : 20.594189,
        "_source" : {
          "date" : "2015-09-03",
          "short_description" : "ANKARA, Turkey (AP) — A Turkish government official says two Vice News journalists who were arrested on terror-related charges",
          "@timestamp" : "2015-09-03T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.comhttp://bigstory.ap.org/article/124170f9fd494c889212138db43467ed/turkish-official-2-vice-news-journalists-freed-jail",
          "category" : "MEDIA",
          "headline" : "Report: VICE Journalists Released From Jail In Turkey",
          "authors" : ""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "bM9bMpEBLxDPEryMej5k",
        "_score" : 16.783123,
        "_source" : {
          "date" : "2016-02-19",
          "short_description" : "Albert Woodfox, the longest-standing solitary confinement prisoner in the US, held in isolation in a six-by-nine-ft cell",
          "@timestamp" : "2016-02-19T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.comhttp://www.theguardian.com/us-news/2016/feb/19/albert-woodfox-released-louisiana-jail-43-years-solitary-confinement",
          "category" : "POLITICS",
          "headline" : "Albert Woodfox To Be Released From Jail After 43 Years In Solitary Confinement",
          "authors" : ""
        }
      }
    ]
  }
}
```

---

# Full Text Query

__Dataset :__ [news](dataset/news.json)

## Search phrases
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "match_phrase": {
      "field-name": {
        "query": "query-search-terms"
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "match_phrase": {
        "headline": "Over 4 Million"
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 32,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {...},
    "max_score" : 13.173777,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "4s5bMpEBLxDPEryMWhnZ",
        "_score" : 13.173777,
        "_source" : {
          "date" : "2022-09-23",
          "short_description" : "Health experts said it is too early to predict whether demand would match up with the 171 million doses of the new boosters the U.S. ordered for the fall.",
          "@timestamp" : "2022-09-23T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/covid-boosters-uptake-us_n_632d719ee4b087fae6feaac9",
          "category" : "U.S. NEWS",
          "headline" : "Over 4 Million Americans Roll Up Sleeves For Omicron-Targeted COVID Boosters",
          "authors" : "Carla K. Johnson, AP"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "ec9bMpEBLxDPEryMfVzv",
        "_score" : 13.173777,
        "_source" : {
          "date" : "2015-11-23",
          "short_description" : "After a slow crawl through the lower federal courts, the fate of President Obama’s long-delayed immigration programs is finally",
          "@timestamp" : "2015-11-23T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.comhttp://thinkprogress.org/justice/2015/11/23/3724905/the-fate-of-over-4-million-people-could-rest-with-justice-scalia/",
          "category" : "POLITICS",
          "headline" : "The Fate Of Over 4 Million People Could Rest With Justice Scalia",
          "authors" : ""
        }
      }
    ]
  }
}
```
If using match_phrase, all hits must meet this criteria :
1. The `Over`, `4`, and `Million` must appear in field
2. The word must appear with that order
3. The word must appear next to each other

## Search Match with multiple fields
The multi_match query runs a match query on multiple fields and calculates a score for each field. Then, it assigns the highest score among the fields to the document.
This score will determine the ranking of the document within the search results.

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "multi_search": {
      "query: "query-search-terms",
      "fields": [
        "list-of-fields",
        "list-of-fields"
      ]
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "multi_match": {
        "query": "Ed Sheeran",
        "fields": [
          "headline",
          "short_description",
          "authors"
        ]
      }
    }
  }
```

Expected response from elasticsearch :
```json
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 2041,
      "relation" : "eq"
    },
    "max_score" : 21.621605,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Ds5bMpEBLxDPEryMbbm9",
        "_score" : 21.621605,
        "_source" : {
          "date" : "2017-03-12",
          "short_description" : "But first, Ed Sheeran will guest-star on the show.",
          "@timestamp" : "2017-03-12T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/game-of-thrones-final-season-six-episodes_us_58c5bceae4b0ed71826d53f1",
          "category" : "ENTERTAINMENT",
          "headline" : "The Final 'Game Of Thrones' Season Will Only Have Six Episodes",
          "authors" : "Matthew Jacobs"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "ds9bMpEBLxDPEryMez9U",
        "_score" : 21.621605,
        "_source" : {
          "date" : "2016-02-16",
          "short_description" : "Ed Sheeran, Meghan Trainor and One Direction also joined in.",
          "@timestamp" : "2016-02-16T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/drake-demi-lovato-mean-tweets_us_56c31bb5e4b0c3c5505283f6",
          "category" : "ENTERTAINMENT",
          "headline" : "'Mean Tweets' Goes From 0 To 100 Real Quick With Drake, Demi Lovato And More",
          "authors" : "Bill Bradley"
        }
      },
      ...
    ]
  }
}
```
That result will show hits that contains `Ed Sheeran` in headline or short_description or author field.

### Boosting field score
To improve the precission, we can give more weight to one field than other field. To boosting, add a carat(^) symbol and weight number.
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "multi_search": {
      "query: "query-search-terms",
      "fields": [
        "list-of-fields^2",
        "list-of-fields"
      ]
    }
  }
}
```
Example : 
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "multi_match": {
        "query": "Ed Sheeran",
        "fields": [
          "headline^2",
          "short_description",
          "authors"
        ]
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 5,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 2041,
      "relation" : "eq"
    },
    "max_score" : 32.629314,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "1M5bMpEBLxDPEryMWiDc",
        "_score" : 32.629314,
        "_source" : {
          "date" : "2021-10-24",
          "short_description" : "The singer said he has tested positive for COVID-19 and will do interviews and performances from his house while he self-isolates.",
          "@timestamp" : "2021-10-24T00:00:00.000+07:00",
          "link" : "https://www.huffpost.com/entry/ed-sheeran-has-covid-will-do-performances-from-home_n_6175b373e4b079111a58f05a",
          "category" : "ENTERTAINMENT",
          "headline" : "Ed Sheeran Has COVID, Will Do Performances From Home",
          "authors" : "The Associated Press, AP"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "885bMpEBLxDPEryMY1cN",
        "_score" : 32.629314,
        "_source" : {
          "date" : "2018-01-20",
          "short_description" : "The pair's cats are happy about the news too, Sheeran announced.",
          "@timestamp" : "2018-01-20T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/ed-sheeran-cherry-seaborn-engaged_us_5a63acc9e4b0e5630070435f",
          "category" : "ENTERTAINMENT",
          "headline" : "Ed Sheeran Is Engaged To Childhood Friend Cherry Seaborn",
          "authors" : "Hilary Hanson"
        }
      },
      ...
    ]
  }
}
```
### Multi match with phrases
Syntax : 
```http
GET {index_name}/_search
{
  "query": {
    "multi_match": {
      "query": "query-search-terms",
      "fields": [
        "list-of-fields^2",
        "list-of-flieds"
      ]
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "multi_match": {
        "query": "party planning", 
        "fields": [
          "headline^2",
          "short_description"
        ],
        "type": "phrase"
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 6,
      "relation" : "eq"
    },
    "max_score" : 28.58702,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "BNBbMpEBLxDPEryMl0sv",
        "_score" : 28.58702,
        "_source" : {
          "date" : "2013-12-31",
          "short_description" : "If you are opting out of the over-the-top party this year and entertaining friends and family at home, I've rounded up a few New Years Eve party-planning musts.",
          "@timestamp" : "2013-12-31T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/new-years-eve-party-planning_us_5b9dbe4fe4b03a1dcc8c53a2",
          "category" : "HOME & LIVING",
          "headline" : "New Years Eve Party Planning Ideas",
          "authors" : """Lauren Nelson, Contributor
Founder, Lauren-Nelson.com"""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Fs9bMpEBLxDPEryMh7wm",
        "_score" : 27.22696,
        "_source" : {
          "date" : "2015-02-18",
          "short_description" : "\"Oh, so this for you, then?\" That's what my neighbor said when I told him a) I was thinking about a Lorax themed birthday party for my almost-3-year-old, and b) she'd probably be happy if the only decor were the three big, white balloons she'd chosen herself that morning.",
          "@timestamp" : "2015-02-18T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/birthday-party-planning-for-the-recovering-perfectionist_b_6667906.html",
          "category" : "PARENTS",
          "headline" : "Birthday Party Planning for the Recovering Perfectionist",
          "authors" : """Tracy Cutchlow, ContributorAuthor of "the coolest--and easiest--book for new parents," sa..."""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "adBbMpEBLxDPEryMkRiC",
        "_score" : 21.994814,
        "_source" : {
          "date" : "2014-05-23",
          "short_description" : "I recently stood in the middle of a madhouse. Kids in electric-orange socks, like a too-bright dystopian fantasy, sprinted past me in every direction. Adults in coordinating electric-orange T-shirts stood guard. All that was missing was the heavy arm of an unseen totalitarian regime. Only, it wasn't exactly missing.",
          "@timestamp" : "2014-05-23T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/the-kids-birthday-party-planning-existential-crisis-looks-like_b_5176064.html",
          "category" : "PARENTS",
          "headline" : "This Is What a Kid's Birthday-Party-Planning Existential Crisis Looks Like",
          "authors" : "Jeff Bogle, ContributorAuthor of OutWithTheKids.com"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "09BbMpEBLxDPEryMn5F1",
        "_score" : 11.295252,
        "_source" : {
          "date" : "2013-06-22",
          "short_description" : "While it seems universally agreed that Paula Deen's admission of using racist language and, uh, party-planning is terrible",
          "@timestamp" : "2013-06-22T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/bill-maher-paula-deen-controversy_us_5bad232ce4b04234e8571f1c",
          "category" : "COMEDY",
          "headline" : "Bill Maher Talks Paula Deen Controversy With 'Real Time' Panel, Defends Deen... Sort Of (VIDEO)",
          "authors" : ""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "CtBbMpEBLxDPEryMo6-F",
        "_score" : 7.5589314,
        "_source" : {
          "date" : "2013-04-04",
          "short_description" : "It's one thing if party planning is a source of a joy for you, but if it's not a priority, foregoing fancy party trappings does not mean that you don't love your child enough or don't care enough about the moment to be celebrated.",
          "@timestamp" : "2013-04-04T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/less-fuss-more-fun_us_5b9cff01e4b03a1dcc839d44",
          "category" : "PARENTING",
          "headline" : "Less Fuss, More Fun",
          "authors" : """Christine Koh, Contributor
Music and brain scientist turned writer, editor, designer, con..."""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "49BbMpEBLxDPEryMl0cv",
        "_score" : 6.835392,
        "_source" : {
          "date" : "2014-01-09",
          "short_description" : """How is a "mancation" different than a bachelor party? These trips are about finding the time to bond with all of your buddies in a new place or with a new activity -- not celebrating one man's last night of singledom. But similar to organizing a bachelor party, planning a mancation takes work.""",
          "@timestamp" : "2014-01-09T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/5-ideas-for-your-next-man_us_5b9dc5ffe4b03a1dcc8cb75e",
          "category" : "TRAVEL",
          "headline" : "5 Ideas for Your Next Mancation",
          "authors" : """U.S. News Travel, Contributor
U.S. News & World Report Travel"""
        }
      }
    ]
  }
}
```
## Combined Query
Sometime, i need to search the data that requires multiple queries. Example, i need to find headline about Ed Sheeran published before the year 2016

One of the ways i can use `bool query` to combine the requirement

### Bool Query
The `bool query` retrieves documents matching boolean combinations of other queries.

With the bool query, i can combine multiple queries into one request and further specify boolean clauses to narrow down the search results.

There are four clauses to choose from :
1. must
document MUST match all of the queries to be considered as a hit
2. must_not
document must NOT match any of the queries
3. should
document does not have to match any queries
4. filter
these filters place document in either yes or no category

Each clause can contain one or multiple queries that specify the criteria of each clause.

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {One or more queries can be specified here}
      ],
      "must_not": [
        {One or more queries can be specified here}
      ],
      "should": [
        {One or more queries can be specified here}
      ],
      "filter": [
        {One or more filter can be specified here}
      ]
    }
  }
}
```
#### Combination of query and aggregation
A bool query can help you answer multi-faceted questions. Before we go over the four clauses of the bool query, we need to first understand what type of questions we can ask about Michelle Obama.

Let's first figure out what headlines have been written about her.

One way to understand that is by searching for categories of headlines that mention Michelle Obama.
Syntax :
```http
GET {index-name}/_search
{
  "query": {
    "match or match_phrase": { "field-name": "value" }
  },
  "aggregations": {
    "aggregation-name": {
      "aggregation-type": {
        "field": "field-name",
        "size": how-many-bucket-returned
      }
    }
  }
}
```
This query will seearch all data that has the prase "Michelle Obama" in the headline and perform aggregations.
Example :
```shell
# Dev tools :
GET news/_search
{
  "query": {
    "match_phrase": {
      "headline": "Michelle Obama"
    }
  },
  "aggregations": {
    "category_mentions": {
      "terms": {
        "field": "category",
        "size": 100
      }
    }
  }
}
```
Expecret response from elasticsearch :
```json
{
  "took" : 28,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 220,
      "relation" : "eq"
    },
    "max_score" : 13.463537,
    "hits" : [{...}]
  },
  "aggregations" : {
    "category_mentions" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 0,
      "buckets" : [
        {
          "key" : "STYLE & BEAUTY",
          "doc_count" : 93
        },
        {
          "key" : "POLITICS",
          "doc_count" : 53
        },
        {
          "key" : "BLACK VOICES",
          "doc_count" : 16
        },
        {
          "key" : "PARENTING",
          "doc_count" : 11
        },
        {
          "key" : "ENTERTAINMENT",
          "doc_count" : 9
        },
        {
          "key" : "STYLE",
          "doc_count" : 8
        },
        {
          "key" : "WELLNESS",
          "doc_count" : 5
        },
        {
          "key" : "WEDDINGS",
          "doc_count" : 4
        },
        {
          "key" : "HEALTHY LIVING",
          "doc_count" : 3
        },
        {
          "key" : "IMPACT",
          "doc_count" : 3
        },
        {
          "key" : "WOMEN",
          "doc_count" : 3
        },
        {
          "key" : "SPORTS",
          "doc_count" : 2
        },
        {
          "key" : "TRAVEL",
          "doc_count" : 2
        },
        {
          "key" : "ARTS & CULTURE",
          "doc_count" : 1
        },
        {
          "key" : "COLLEGE",
          "doc_count" : 1
        },
        {
          "key" : "COMEDY",
          "doc_count" : 1
        },
        {
          "key" : "LATINO VOICES",
          "doc_count" : 1
        },
        {
          "key" : "PARENTS",
          "doc_count" : 1
        },
        {
          "key" : "TASTE",
          "doc_count" : 1
        },
        {
          "key" : "THE WORLDPOST",
          "doc_count" : 1
        },
        {
          "key" : "U.S. NEWS",
          "doc_count" : 1
        }
      ]
    }
  }
}
```
#### The must clause
Defines all queries(criteria) a document MUST match to be returned as hits. These criteria are expressed in the form of one or multiple queries.

All queries in the must clause must be satisfied for a document to be returned as a hit. As a result, having more queries in the must clause will increase the precision of your query.

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {
        "match or match_phrase": {
          "field-name": "value" 
         }
        },
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        }
      ]
    }
  }
}
```
Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "bool": {
        "must": [
          {
            "match_phrase": {
              "headline": "Michelle Obama"
            }
          },
          {
            "match": {
              "category": "POLITICS"
            }
          }
        ]
      }
    }
  }
```
Expected response from elasticsearch :
```json
{
  "took" : 5,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 53,
      "relation" : "eq"
    },
    "max_score" : 15.235979,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "LM9bMpEBLxDPEryMhbDZ",
        "_score" : 15.235979,
        "_source" : {
          "date" : "2015-03-25",
          "short_description" : "",
          "@timestamp" : "2015-03-25T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-jeopardy_n_6939122.html",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Appears On 'Jeopardy!'",
          "authors" : "Amber Ferguson"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "689bMpEBLxDPEryMeChZ",
        "_score" : 14.563438,
        "_source" : {
          "date" : "2016-04-22",
          "short_description" : "The first lady is becoming a prime-time regular.",
          "@timestamp" : "2016-04-22T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-ncis_us_571a6dece4b0d0042da92644",
          "category" : "POLITICS",
          "headline" : "Michelle Obama To Appear On 'NCIS'",
          "authors" : "Mariah Stewart"
        }
      },
      ...
      }
    ]
  }
}
```
#### The must_not clause
The must_not clause defines queries(criteria) a document MUST NOT match to be included in the search results

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        },
      "must_not": [
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        }
      ]
    }
  }
}
```
What if you want all Michelle Obama headlines except for the ones that belong in the "WEDDINGS" category?

Example :
```shell
# Dev tools :
  GET news/_search
  {
    "query": {
      "bool": {
        "must": {
          "match_phrase": {
            "headline": "Michelle Obama"
           }
          },
        "must_not":[
          {
            "match": {
              "category": "WEDDINGS"
            }
          }
        ]
      }
    }
  }
```
The query will sesarch the data in the field headline and excludes all documents that contain the term "WEDDINGS" in the field category.

Expected response from elasticsearch :
```json
{
  "took" : 6,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 216,
      "relation" : "eq"
    },
    "max_score" : 13.463537,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "LM9bMpEBLxDPEryMhbDZ",
        "_score" : 13.463537,
        "_source" : {
          "date" : "2015-03-25",
          "short_description" : "",
          "@timestamp" : "2015-03-25T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-jeopardy_n_6939122.html",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Appears On 'Jeopardy!'",
          "authors" : "Amber Ferguson"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Vc9bMpEBLxDPEryMe0ZV",
        "_score" : 12.18245,
        "_source" : {
          "date" : "2016-01-27",
          "short_description" : "The talk show host really loved interviewing FLOTUS.",
          "@timestamp" : "2016-01-27T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/tamar-braxton-says-michelle-obama-inspired-her_us_56a8ffaee4b0f6b7d5447f06",
          "category" : "BLACK VOICES",
          "headline" : "Tamar Braxton Says Michelle Obama Inspired Her",
          "authors" : "Brennan Williams"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "sM5bMpEBLxDPEryMZ4I0",
        "_score" : 12.18245,
        "_source" : {
          "date" : "2017-08-24",
          "short_description" : "Her stance is deeply rooted.",
          "@timestamp" : "2017-08-24T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-beets_us_599ecaf4e4b06d67e3359a91",
          "category" : "TASTE",
          "headline" : "There's One Vegetable Michelle Obama Truly Hates",
          "authors" : "Jamie Feldman"
        }
      },
      ...
    ]
  }
}
```
#### The should clause
The should clause adds "nice to have" queries. The documents do not need to match the "nice to have" queries to be considered as hits.

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        }
      ],
      "should":[
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        }
      ]
    }
  }
```
Example :
```shell
# Dev tools :
GET news/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "should":[
         {
          "match_phrase": {
            "category": "BLACK VOICES"
          }
        }
      ]
    }
  }
}
```
The documents with the phrase "BLACK VOICES" in the field category are now presented at the top of the search results.

Expected response from elasticsearch :
```json
{
  "took" : 11,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 220,
      "relation" : "eq"
    },
    "max_score" : 16.004845,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Vc9bMpEBLxDPEryMe0ZV",
        "_score" : 16.004845,
        "_source" : {
          "date" : "2016-01-27",
          "short_description" : "The talk show host really loved interviewing FLOTUS.",
          "@timestamp" : "2016-01-27T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/tamar-braxton-says-michelle-obama-inspired-her_us_56a8ffaee4b0f6b7d5447f06",
          "category" : "BLACK VOICES",
          "headline" : "Tamar Braxton Says Michelle Obama Inspired Her",
          "authors" : "Brennan Williams"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "utBbMpEBLxDPEryMp9Sz",
        "_score" : 15.451572,
        "_source" : {
          "date" : "2012-12-23",
          "short_description" : "As part of HuffPost BlackVoices weekly series counting down the top eight power couples of the year, we present “BV Power",
          "@timestamp" : "2012-12-23T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/couple-of-the-year-countdown-barack-michelle-obama_us_5badce58e4b0bb1705fae938",
          "category" : "BLACK VOICES",
          "headline" : "Couple Of The Year Countdown: Barack & Michelle Obama",
          "authors" : ""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "d85bMpEBLxDPEryMdP2T",
        "_score" : 14.946371,
        "_source" : {
          "date" : "2016-08-26",
          "short_description" : "Sumpter stars as FLOTUS in a new film that chronicles Barack Obama's first date with Michelle.",
          "@timestamp" : "2016-08-26T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/what-portraying-michelle-obama-taught-tika-sumpter-about-empowerment_us_57c0717ce4b085c1ff292dbe",
          "category" : "BLACK VOICES",
          "headline" : "What Portraying Michelle Obama Taught Tika Sumpter About Empowerment",
          "authors" : "Lilly Workneh"
        }
      },
      ...
      }
    ]
  }
}
```
#### The filter clause
The filter clause contains filter queries that place documents into either "yes" or "no" category. The filter clause only includes documents that fall into the yes category.

Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match or match_phrase": {
            "field-name": "value" 
          }
        }
      ],
      "filter":{
        "range":{
          "date": {
            "gte": "lowest value",
            "lte": "highest value"
          }
        }
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
GET news/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "filter": {
        "range": {
          "date": {
            "gte": "2014-03-25",
            "lte": "2016-03-25"
          }
        }
      }
    }
  }
}
```
Expected response from elasticsearch :
```json
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 33,
      "relation" : "eq"
    },
    "max_score" : 13.463537,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "LM9bMpEBLxDPEryMhbDZ",
        "_score" : 13.463537,
        "_source" : {
          "date" : "2015-03-25",
          "short_description" : "",
          "@timestamp" : "2015-03-25T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-jeopardy_n_6939122.html",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Appears On 'Jeopardy!'",
          "authors" : "Amber Ferguson"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Vc9bMpEBLxDPEryMe0ZV",
        "_score" : 12.18245,
        "_source" : {
          "date" : "2016-01-27",
          "short_description" : "The talk show host really loved interviewing FLOTUS.",
          "@timestamp" : "2016-01-27T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/tamar-braxton-says-michelle-obama-inspired-her_us_56a8ffaee4b0f6b7d5447f06",
          "category" : "BLACK VOICES",
          "headline" : "Tamar Braxton Says Michelle Obama Inspired Her",
          "authors" : "Brennan Williams"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "s9BbMpEBLxDPEryMkRyD",
        "_score" : 12.18245,
        "_source" : {
          "date" : "2014-05-10",
          "short_description" : "",
          "@timestamp" : "2014-05-10T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-commencement-speech_n_5302503.html",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Urges Graduates To Stay Hungry",
          "authors" : "Chris Gentilviso"
        }
      },
      ...
      }
    ]
  }
}
```
#### Finetuning the relevance of bool queries
There are many ways you can fine-tune the relevance of bool queries. One of the ways is to add multiple queries under the should clause.

##### Adding multiple queries under the should clause
This approach ensures that you maintain a high recall but also offers a way to present more precise search results at the top of your search results.
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match or match_phrase": {
            "field-name": "value"
          }
        }
      ],
      "should": [
        {
          "match or match_phrase": {
            "field-name": "value"
          }
        },
        {
          "match or match_phrase": {
            "field-name": "value"
          }
        },
        {
          "match or match_phrase": {
            "field-name": "value"
          }
        }
      ]
    }
  }
}
```
Lets say you want to run a search for news headlines with the phrase "Michelle Obama" in the field headline. But you want to favor articles that mention her biography "Becoming", and terms like "women" and "empower".

To do this, you can add multiple queries to the should clause.

Example :
```shell
# Dev tools :
GET news/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match_phrase": {
            "headline": "Michelle Obama"
          }
        }
      ],
      "should": [
        {
          "match": {
            "headline": "becoming"
          }
        },
        {
          "match": {
            "headline": "women"
          }
        },
        {
          "match": {
            "headline": "empower"
          }
        }
      ]
    }
  }
}
```
Expected response from elasticsearch :
```json
{
  "took" : 7,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 220,
      "relation" : "eq"
    },
    "max_score" : 19.119379,
    "hits" : [
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Ec5bMpEBLxDPEryMXzxy",
        "_score" : 19.119379,
        "_source" : {
          "date" : "2018-05-24",
          "short_description" : "\"The process of writing this book has been so personally meaningful and illuminating for me.\"",
          "@timestamp" : "2018-05-24T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-cover-memoir-becoming_us_5b06c7f2e4b05f0fc8458cb4",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Reveals Cover For Upcoming Memoir 'Becoming'",
          "authors" : "Jenna Amatulli"
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "b9BbMpEBLxDPEryMjgHb",
        "_score" : 12.317407,
        "_source" : {
          "date" : "2014-07-30",
          "short_description" : "",
          "@timestamp" : "2014-07-30T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/michelle-obama-gender-women_n_5634915.html",
          "category" : "POLITICS",
          "headline" : "Michelle Obama Tells Men To Ask Themselves If They 'Truly View Women As Their Equals'",
          "authors" : ""
        }
      },
      {
        "_index" : "news",
        "_type" : "_doc",
        "_id" : "Vc9bMpEBLxDPEryMe0ZV",
        "_score" : 12.18245,
        "_source" : {
          "date" : "2016-01-27",
          "short_description" : "The talk show host really loved interviewing FLOTUS.",
          "@timestamp" : "2016-01-27T00:00:00.000+07:00",
          "link" : "https://www.huffingtonpost.com/entry/tamar-braxton-says-michelle-obama-inspired-her_us_56a8ffaee4b0f6b7d5447f06",
          "category" : "BLACK VOICES",
          "headline" : "Tamar Braxton Says Michelle Obama Inspired Her",
          "authors" : "Brennan Williams"
        }
      },
      ...
      }
    ]
  }
}
```

---

# Aggregations APIs

__Dataset :__ [news](dataset/ecommerce-data.csv)

An aggregation will summerize our data as metrics, statistics, and other analytics.

## Pre-requirements
1. Create new index with this mapping
```shell
# Dev tools :
PUT {index_name}
{
  "mappings": {
    "properties": {
      "Country": {
        "type": "keyword"
      },
      "CustomerID": {
        "type": "long"
      },
      "Description": {
        "type": "text"
      },
      "InvoiceDate": {
        "type": "date",
        "format": "M/d/yyyy H:m"
      },
      "InvoiceNo": {
        "type": "keyword"
      },
      "Quantity": {
        "type": "long"
      },
      "StockCode": {
        "type": "keyword"
      },
      "UnitPrice": {
        "type": "double"
      }
    }
  }
}
```
2. Import sample dataset and reindex it into previous created new index
```shell
# Dev tools :
POST _reindex
{
  "source": {
    "index": "source-index"
  },
  "dest": {
    "index": "{index_name}
  }
}
```
3. Remove negative values from `UnitPrice`
```shell
POST {index_name}/_delete_by_query
{
  "query": {
    "range": {
      "UnitPrice": {
        "lte": 0
      }
    }
  }
}
```
4. Remove values greater than 500 from `UnitPrice`
```shell
POST {index_name}/_delete_by_query
{
  "query": {
    "range": {
      "UnitPrice": {
        "gte": 500
      }
    }
  }
}
```


## Aggregations Request
Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "aggregation-type": {
        "field": "field-name-to-be-aggregated"
      }
    }
  }
}
```
## Metric Aggregations
Used to compute numeric values. It can be used to calculate the values of `sum`, `min`, `max`, `avg`, `cardinality`, and etc

### Sum all unit prices in the index
Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "sum": {
        "field": "field-name-to-be-aggregated"
      }
    }
  }
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "sum_unit_price": {
      "sum": {
        "field": "UnitPrice"
      }
    }
  }
}
```
Expected response from elasticsearch :
```json
{
  "took" : 64,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : 1.0,
    "hits" : [{...}]
  },
  "aggregations" : {
    "sum_unit_price" : {
      "value" : 1946449.894
    }
  }
}
```
### Get the lowest(min) unit price in the index
Syntax :
```http
GET {index_name}/_search
{
  "aggs" {
    "aggregation-name": {
      "min": {
        "field": "field-name-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools
GET ecommerce/_search
{
  "aggs": {
    "lowest_price": {
  	  "min": {
    	  "field": "UnitPrice"
  	  }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 31,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "lowest_price" : {
      "value" : 0.001
    }
  }
}
```
### Get the highest(max) unit price in the index
Syntax :
```http
GET {index_name}/_search
{
  "aggs" {
    "aggregation-name": {
      "min": {
        "field": "field-name-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "highest_price": {
      "max": {
    	  "field": "UnitPrice"
  	  }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "lowest_price" : {
      "value" : 498.79
    }
  }
}
```
### Get the average unit price in the index
Syntax :
```http
GET {index_name}/_search
{
  "aggs" {
    "aggregation-name": {
      "avg": {
        "field": "field-name-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "average_price": {
      "avg": {
    	  "field": "UnitPrice"
  	  }
    }
  },
  "size": 0
}
```
Expected result from elasticsearch :
```json
{
  "took" : 34,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "average_price" : {
      "value" : 3.6103066456206867
    }
  }
}
```
### Compute the count, min,max, avg, sum in one go
Syntax :
```http
GET {index_name}/_search
{
  "aggs" {
    "aggregation-name": {
      "stats": {
        "field": "field-name-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "all_stats": {
  	  "stats": {
    	  "field": "UnitPrice"
  	  }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 44,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "all_stats" : {
      "count" : 539137,
      "min" : 0.001,
      "max" : 498.79,
      "avg" : 3.6103066456206867,
      "sum" : 1946449.894
    }
  }
}
```
### Count the unique values
Syntax :
```http
GET {index_name}/_search
{
  "aggs" {
    "aggregation-name": {
      "cardinality": {
        "field": "field-name-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "unique-customers": {
  	  "cardinality": {
    	  "field": "CustomerID"
  	  }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 70,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "unique-customers" : {
      "value" : 1412
    }
  }
}
```
### Limit aggregation scope
To limit the scope of the aggregation, you can add a query clause to the aggregations request. The query clause defines the subset of documents that aggregations should be performed on.
Syntax :
```http
GET {index_name}/_search
{
  "query": {
    "match or match_phrase": {
      "field-name": "value"
    }
  },
  "aggregations": {
    "aggregation-name": {
      "aggregation-type": {
        "field": "field-to-be-aggregated"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "query": {
    "match": {
      "Country": "Japan"
    }
  },
  "aggs": {
    "japan_average_unit_price": {
      "avg": {
        "field": "UnitPrice"
      }
    }
  },
  "size": 0
}
```
Expected respons from elasticsearch :
```json
{
  "took" : 1,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 358,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "japan_average_unit_price" : {
      "value" : 2.276145251396648
    }
  }
}
```

## Bucket Aggregation
Bucket aggregations group documents into several sets of documents called buckets. All documents in a bucket share a common criteria

### Date histogram aggregation
Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "date_histogram": {
        "field":"field-name-to-be-aggregated",
        "fixed_interval": "interval"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transactions_by_8_hrs": {
      "date_histogram": {
        "field": "InvoiceDate",
        "fixed_interval": "8h"
      }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 43,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "transactions_by_8_hrs" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2010 8:0",
          "key" : 1291190400000,
          "doc_count" : 2291
        },
        {
          "key_as_string" : "12/1/2010 16:0",
          "key" : 1291219200000,
          "doc_count" : 805
        },
        {
          "key_as_string" : "12/2/2010 0:0",
          "key" : 1291248000000,
          "doc_count" : 10
        },
        ...
      ]
    }
  }
}
```
#### Calendar Interval
A scenario where you might use the calendar_interval is when you want to calculate the monthly transaction.

Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "date_histogram": {
        "field":"field-name-to-be-aggregated",
        "calendar_interval": "interval"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "monthly_transaction": {
      "date_histogram": {
        "field": "InvoiceDate",
        "calendar_interval": "1M"
      }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 42,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {
    "total" : {
      "value" : 10000,
      "relation" : "gte"
    },
    "max_score" : null,
    "hits" : [ ]
  },
  "aggregations" : {
    "monthly_transaction" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2010 0:0",
          "key" : 1291161600000,
          "doc_count" : 42170
        },
        {
          "key_as_string" : "1/1/2011 0:0",
          "key" : 1293840000000,
          "doc_count" : 34999
        },
        {
          "key_as_string" : "2/1/2011 0:0",
          "key" : 1296518400000,
          "doc_count" : 27573
        },
        {
          "key_as_string" : "3/1/2011 0:0",
          "key" : 1298937600000,
          "doc_count" : 36491
        },
        ...
      ]
    }
  }
}
```
#### Bucket sorting
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "monthly_transaction": {
      "date_histogram": {
        "field": "InvoiceDate",
        "calendar_interval": "1M",
        "order": {
          "_key": "desc"
        }
      }
    }
  },
  "size": 0
}

```
Expected response from elasticsearch :
```json
{
  "took" : 4,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "monthly_transaction" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2011 0:0",
          "key" : 1322697600000,
          "doc_count" : 25453
        },
        {
          "key_as_string" : "11/1/2011 0:0",
          "key" : 1320105600000,
          "doc_count" : 84401
        },
        {
          "key_as_string" : "10/1/2011 0:0",
          "key" : 1317427200000,
          "doc_count" : 60474
        },
        ...
      ]
    }
  }
}
```

### Histogram aggregation
The histogram aggregation creates buckets based on any numerical interval.
Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "histogram": {
        "field":"field-name-to-be-aggregated",
        "interval": "interval"
      }
    }
  },
  "size": 0
}
```
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transactions_per_price": {
      "histogram": {
        "field": "UnitPrice",
        "interval": 10
      }
    }
  },
  "size": 0
}
```
#### Bucket Sorting
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transaction_per_price": {
      "histogram": {
        "field": "UnitPrice",
        "interval": "10",
        "order": {
          "_key": "desc"
        }
      }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "monthly_transaction" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2011 0:0",
          "key" : 1322697600000,
          "doc_count" : 25453
        },
        {
          "key_as_string" : "11/1/2011 0:0",
          "key" : 1320105600000,
          "doc_count" : 84401
        },
        {
          "key_as_string" : "10/1/2011 0:0",
          "key" : 1317427200000,
          "doc_count" : 60474
        },
        ...
      ]
    }
  }
}
```

### Range aggregation
The range aggregation is similar to the histogram aggregation in that it can create buckets based on any numerical interval. The difference is that the range aggregation allows you to define intervals of varying sizes so you can customize it to your use case.

Syntax :
```http
GET {index-name}/_search
{
  "aggs": {
   "aggregation-name": {
      "range": {
        "field": "field-name-to-be-aggregated",
        "ranges": [
          {
            "to": x
          },
          {
            "from": x,
            "to": y
          },
          {
            "from": z
          }
        ]
      }
    }
  },
  "size": 0
}
```

Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transactions_per_custom_price_ranges": {
      "range": {
        "field": "UnitPrice",
        "ranges": [
          {
            "to": 50
          },
          {
            "from": 50,
            "to": 200
          },
          {
            "from": 200
          }
        ]
      }
    }
  },
  "size": 0
}
```

Expected response from elasticsearch :
```json
{
  "took" : 18,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "transactions_per_custom_price_ranges" : {
      "buckets" : [
        {
          "key" : "*-50.0",
          "to" : 50.0,
          "doc_count" : 537975
        },
        {
          "key" : "50.0-200.0",
          "from" : 50.0,
          "to" : 200.0,
          "doc_count" : 855
        },
        {
          "key" : "200.0-*",
          "from" : 200.0,
          "doc_count" : 307
        }
      ]
    }
  }
}
```

### Terms aggregation
The terms aggregation creates a new bucket for every unique term it encounters for the specified field. It is often used to find the most frequently found terms in a document.

Syntax :
```http
GET {index_name}/_search
{
  "aggs": {
    "aggregation-name": {
      "terms": {
        "field": "field-to-be-aggregated",
        "size": how many top result
      }
    }
  }
}
```

Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "top_5_customers": {
      "terms": {
        "field": "CustomerID",
        "size": 5
      }
    }
  },
  "size": 0
}
```

Expected response from elasticsearch :
```json
{
  "took" : 54,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "top_5_customers" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 380293,
      "buckets" : [
        {
          "key" : 17841,
          "doc_count" : 7983
        },
        {
          "key" : 14911,
          "doc_count" : 5897
        },
        {
          "key" : 14096,
          "doc_count" : 5110
        },
        {
          "key" : 12748,
          "doc_count" : 4638
        },
        {
          "key" : 14606,
          "doc_count" : 2782
        }
      ]
    }
  }
}
```
#### Bucket Sorting
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "top_5_customers": {
      "terms": {
        "field": "CustomerID",
        "size": 5,
        "order": {
          "_key": "asc"
        }
      }
    }
  },
  "size": 0
}
```

Expected response from elasticsearch :
```json
{
  "took" : 71,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "top_5_customers" : {
      "doc_count_error_upper_bound" : 0,
      "sum_other_doc_count" : 406398,
      "buckets" : [
        {
          "key" : 12346,
          "doc_count" : 2
        },
        {
          "key" : 12347,
          "doc_count" : 182
        },
        {
          "key" : 12348,
          "doc_count" : 31
        },
        {
          "key" : 12349,
          "doc_count" : 73
        },
        {
          "key" : 12350,
          "doc_count" : 17
        }
      ]
    }
  }
}
```

## Combined aggregations
We can combine the metric aggregations and bucket aggregations to solve complex questions. For example, lets say we wanted to know the sum of revenue per day.

### Calculate daily revenue
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transactions_per_day": {
      "date_histogram": {
        "field": "InvoiceDate",
        "calendar_interval": "day"
      },
      "aggs": {
        "daily_revenue": {
          "sum": {
            "script": {
              "source": "doc['UnitPrice'].value * doc['Quantity'].value"
            }
          }
        }
      }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 838,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "transactions_per_day" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2010 0:0",
          "key" : 1291161600000,
          "doc_count" : 3096,
          "daily_revenue" : {
            "value" : 57458.3
          }
        },
        {
          "key_as_string" : "12/2/2010 0:0",
          "key" : 1291248000000,
          "doc_count" : 2107,
          "daily_revenue" : {
            "value" : 46207.28
          }
        },
        {
          "key_as_string" : "12/3/2010 0:0",
          "key" : 1291334400000,
          "doc_count" : 2168,
          "daily_revenue" : {
            "value" : 44732.94
          }
        },
        ...
      ]
    }
  }
}
```

### Calculate multiple metrcs per bucket
Example :
```shell
# Dev tools :
GET ecommerce/_search
{
  "aggs": {
    "transactions_per_day": {
      "date_histogram": {
        "field": "InvoiceDate",
        "calendar_interval": "day"
      },
      "aggs": {
        "daily_revenue": {
          "sum": {
            "script": {
              "source": "doc['UnitPrice'].value * doc['Quantity'].value"
            }
          }
        },
        "number_of_unique_customers_per_day": {
          "cardinality": {
            "field": "CustomerID"
          }
        }
      }
    }
  },
  "size": 0
}
```
Expected response from elasticsearch :
```json
{
  "took" : 237,
  "timed_out" : false,
  "_shards" : {...},
  "hits" : {...},
  "aggregations" : {
    "transactions_per_day" : {
      "buckets" : [
        {
          "key_as_string" : "12/1/2010 0:0",
          "key" : 1291161600000,
          "doc_count" : 3096,
          "number_of_unique_customers_per_day" : {
            "value" : 98
          },
          "daily_revenue" : {
            "value" : 57458.3
          }
        },
        {
          "key_as_string" : "12/2/2010 0:0",
          "key" : 1291248000000,
          "doc_count" : 2107,
          "number_of_unique_customers_per_day" : {
            "value" : 117
          },
          "daily_revenue" : {
            "value" : 46207.28
          }
        },
        ...
      ]
    }
  }
}
```


# Mapping
## Indexing a Document
The following request will index the following document.  

Syntax: 
```
POST {index-name}/_doc
{
  "field": "value"
}
```
Example: 
```
POST temp_index/_doc
{
  "name": "Pineapple",
  "botanical_name": "Ananas comosus",
  "produce_type": "Fruit",
  "country_of_origin": "New Zealand",
  "date_purchased": "2020-06-02T12:15:35",
  "quantity": 200,
  "unit_price": 3.11,
  "description": "a large juicy tropical fruit consisting of aromatic edible yellow flesh surrounded by a tough segmented skin and topped with a tuft of stiff leaves.These pineapples are sourced from New Zealand.",
  "vendor_details": {
    "vendor": "Tropical Fruit Growers of New Zealand",
    "main_contact": "Hugh Rose",
    "vendor_location": "Whangarei, New Zealand",
    "preferred_vendor": true
  }
}
```

Expected response from elasticsearch : 

Elasticsearch will confirm that this document has been successfully indexed into the temp_index. 
```json
{
  "_index" : "temp_index",
  "_type" : "_doc",
  "_id" : "qKzoapEBdNf0rVGjiK8W",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
```

## Mapping Explained
Mapping determines how a document and its fields are indexed and stored by defining the type of each field.

```shell
GET temp_index/_mapping
```

```json
#! Elasticsearch built-in security features are not enabled. Without authentication, your cluster could be accessible to anyone. See https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html to enable security.
{
  "temp_index" : {
    "mappings" : {
      "properties" : {
        "quantity" : { <<-- Field name
          "type" : "long" <<-- Field type
        },
        "unit_price" : { <<-- Field name
          "type" : "float" <<-- Field type
        },
        "vendor_details" : {
          "properties" : {
            "main_contact" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "preferred_vendor" : {
              "type" : "boolean"
            },
            "vendor" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            },
            "vendor_location" : {
              "type" : "text",
              "fields" : {
                "keyword" : {
                  "type" : "keyword",
                  "ignore_above" : 256
                }
              }
            }
          }
        }
      }
    }
  }
}
```
It contains a list of the names and types of fields in an index. Depending on its type, each field is indexed and stored differently in Elasticsearch.

### Dynamic Mapping
When a user does not define mapping in advance, Elasticsearch creates or updates the mapping as needed by default. This is known as `dynamic mapping`. 

With `dynamic mapping`, Elasticsearch looks at each field and tries to infer the data type from the field content. Then, it assigns a type to each field and creates a list of field names and types known as mapping.  

Depending on the assigned field type, each field is indexed and primed for different types of requests(full text search, aggregations, sorting). This is why mapping plays an important role in how Elasticsearch stores and searches for data. 

For the list of all field types, click [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html)!

### Indexing Strings 
There are two kinds of string field types:
1. Text
2. Keyword

By default, every string gets mapped twice as a text field and as a keyword multi-field. Each field type is primed for different types of requests. 

`Text` field type is designed for full-text searches. 

`Keyword` field type is designed for exact searches, aggregations, and sorting.

You can customize your mapping by assigning the field type as either text or keyword or both! 

#### Text Field Type
##### Text Analysis
Ever notice that when you search in Elasticsearch, it is not case sensitive or punctuation does not seem to matter? This is because `text analysis` occurs when your fields are indexed. 

When indexing the text "These pineapples are sourced from New Zealand" in elasticsearch, the text goes through a process called tokenization. Tokenization breaks down the text into individual tokens or terms. By default, Elasticsearch uses the standard tokenizer, which splits the text on whitespace and punctuation

Example, we put some doc with id `1` into some index with this value "These pineapples are sourced from New Zealand" :

```shell
"these"       – This is the first token.
"pineapples"  – This is the second token.
"are"         – This is the third token.
"sourced"     – This is the fourth token.
"from"        – This is the fifth token.
"new"         – This is the sixth token.
"zealand"     – This is the seventh token.
```

So, the tokens for the given text would be: ["These", "pineapples", "are", "sourced", "from", "New", "Zealand"].

__Inverted Index__

Once the string is analyzed, the individual tokens are stored in a sorted list known as the `inverted index`. An inverted index stores a mapping from terms to their occurrences in documents

|Term          | Document IDs |
|--------------|------------ |
|these         | [1] |
|pineapples    | [1] |
|are           | [1] |
|sourced       | [1] |
|from          | [1] |
|new           | [1] |
|zealand       | [1] |

The same process occurs every time you index a new document.

Example, we put new doc "These pineapples are sourced from Capadocia" into some index sith id `2`

|Term          | Document IDs |
|--------------|------------ |
|these         | [1][2] |
|capadocia     | [2] |
|pineapples    | [1][2] |
|are           | [1][2] |
|sourced       | [1][2] |
|from          | [1][2] |
|new           | [1] |
|zealand       | [1] |

> __NOTE:__
> - Text field type is optimal for full text search
> - By default, string get mapped twice as text and keyword

Text used for full text search :
|Term          | Document IDs |
|--------------|------------ |
|these         | [1][2] |
|capadocia     | [2] |
|pineapples    | [1][2] |


Keyword used for aggregations, sorting, exact searches :
|Document IDs | Document Values |
|-------------|-----------------|
|[1]          | New Zealand     |
|[2]          | Capadocia       |


#### Keyword Field Type
`Keyword` field type is used for aggregations, sorting, and exact searches. These actions look up the document ID to find the values it has in its fields. 

`Keyword` field is suited to perform these actions because it uses a data structure called `doc values` to store data. 

For each document, the document id along with the field value(original string) are added to the table. This data structure(`doc values`) is designed for actions that require looking up the document ID to find the values it has in its fields.

|Document IDs | Document Values |
|-------------|-----------------|
|[1]          | New Zealand     |
|[2]          | Capadocia       |

When Elasticsearch dynamically creates a mapping for you, it does not know what you want to use a string for so it maps all strings to both field types. 

In cases where you do not need both field types, the default setting is wasteful. Since both field types require creating either an inverted index or doc values, creating both field types for unnecessary fields will slow down indexing and take up more disk space.

This is why we define our own mapping as it helps us store and search data more efficiently.

### Defining your own mapping
__Rules__
1. If you do not define a mapping ahead of time, Elasticsearch dynamically creates the mapping for you.
2. If you do decide to define your own mapping, you can do so at index creation.
3. ONE mapping is defined per index. Once the index has been created, we can only add *new* fields to a mapping. We CANNOT change the mapping of an *existing* field. 
4. If you must change the type of an existing field, you must create a new index with the desired mapping, then reindex all documents into the new index. 

__Step 1: Index a sample document into a test index.__

The sample document must contain the fields that you want to define. These fields must also contain values that map closely to the field types you want. 

Syntax:
```http
POST {index-name}/_doc
{
  "field": "value"
}
```

Example:
```shell
POST test_index/_doc
{
  "name": "Pineapple",
  "botanical_name": "Ananas comosus",
  "produce_type": "Fruit",
  "country_of_origin": "New Zealand",
  "date_purchased": "2020-06-02T12:15:35",
  "quantity": 200,
  "unit_price": 3.11,
  "description": "a large juicy tropical fruit consisting of aromatic edible yellow flesh surrounded by a tough segmented skin and topped with a tuft of stiff leaves.These pineapples are sourced from New Zealand.",
  "vendor_details": {
    "vendor": "Tropical Fruit Growers of New Zealand",
    "main_contact": "Hugh Rose",
    "vendor_location": "Whangarei, New Zealand",
    "preferred_vendor": true
  }
}
```

Expected response from elasticsearch :
```json
{
  "_index" : "test_index",
  "_type" : "_doc",
  "_id" : "qaxga5EBdNf0rVGj3q9E",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 1,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
```

__Step 2: View the dynamic mapping__ 

Syntax:
```http
GET {index-name}/_mapping
```

Example:
```shell
GET test_index/_mapping
```

Expected response from elasticsearch :
Elasticsearch will display the mapping it has created. It lists the fields in an alphabetical order. This document is identical to the one we indexed into the temp_index.

```json
{
  "test_index" : {
    "mappings" : {
      "properties" : {
        "botanical_name" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "country_of_origin" : {
          "type" : "text",
          "fields" : {
            "keyword" : {
              "type" : "keyword",
              "ignore_above" : 256
            }
          }
        },
        "date_purchased" : {
          "type" : "date"
        },
        ...
      }
    }
  }
}
```

__Step 3: Edit the mapping__

Copy and paste the mapping from step 2 into the Kibana console. From the pasted results, remove the "test_index" along with its opening and closing brackets. Then, edit the mapping to satisfy the requirements outlined in the figure below.

The optimized mapping should look like the following: 
```json
{
  "mappings": {
    "properties": {
      "botanical_name": {
        "enabled": false
      },
      "country_of_origin": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword"
          }
        }
      },
      "date_purchased": {
        "type": "date"
      },
      "description": {
        "type": "text"
      },
      "name": {
        "type": "text"
      },
      "produce_type": {
        "type": "keyword"
      },
      "quantity": {
        "type": "long"
      },
      "unit_price": {
        "type": "float"
      },
      "vendor_details": {
        "enabled": false
      }
    }
  }
}
```

__Step 4: Create a new index with the optimized mapping from step 3.__ 

Syntax:
```
PUT {index-name}
{
  copy and paste your edited mapping here
}
```

Example: 
```shell
PUT produce_index
{
  "mappings": {
    "properties": {
      "botanical_name": {
        "enabled": false
      },
      "country_of_origin": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword"
          }
        }
      },
      "date_purchased": {
        "type": "date"
      },
      "description": {
        "type": "text"
      },
      "name": {
        "type": "text"
      },
      "produce_type": {
        "type": "keyword"
      },
      "quantity": {
        "type": "long"
      },
      "unit_price": {
        "type": "float"
      },
      "vendor_details": {
        "enabled": false
      }
    }
  }
}
```

Expected response from elasticsearch :
Elasticsearch creates a produce_index with the customized mapping we defined
```json
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "produce_index"
}
```

__Step 5: Check the mapping of the new index to make sure the all the fields have been mapped correctly__
Syntax:
```
GET {index-name}/_mapping
```

Example:
```
GET produce_index/_mapping
```

Compared to the dynamic mapping, our optimized mapping looks more simple and concise! The current mapping satisfies the requirements that are marked with green check marks

__Step 6: Index your dataset into the new index__

For simplicity's sake, we will index two documents. 

*Index the first document*

```shell
POST produce_index/_doc
{
  "name": "Pineapple",
  "botanical_name": "Ananas comosus",
  "produce_type": "Fruit",
  "country_of_origin": "New Zealand",
  "date_purchased": "2020-06-02T12:15:35",
  "quantity": 200,
  "unit_price": 3.11,
  "description": "a large juicy tropical fruit consisting of aromatic edible yellow flesh surrounded by a tough segmented skin and topped with a tuft of stiff leaves.These pineapples are sourced from New Zealand.",
  "vendor_details": {
    "vendor": "Tropical Fruit Growers of New Zealand",
    "main_contact": "Hugh Rose",
    "vendor_location": "Whangarei, New Zealand",
    "preferred_vendor": true
  }
}
```

*Index the second document*

The second document has almost identical fields as the first document except that it has an extra field called "organic" set to true!

```shell
POST produce_index/_doc
{
  "name": "Mango",
  "botanical_name": "Harum Manis",
  "produce_type": "Fruit",
  "country_of_origin": "Indonesia",
  "organic": true,
  "date_purchased": "2020-05-02T07:15:35",
  "quantity": 500,
  "unit_price": 1.5,
  "description": "Mango Arumanis or Harum Manis is originated from East Java. Arumanis means harum dan manis or fragrant and sweet just like its taste. The ripe Mango Arumanis has dark green skin coated with thin grayish natural wax. The flesh is deep yellow, thick, and soft with little to no fiber. Mango Arumanis is best eaten when ripe.",
  "vendor_details": {
    "vendor": "Ayra Shezan Trading",
    "main_contact": "Suharto",
    "vendor_location": "Binjai, Indonesia",
    "preferred_vendor": true
  }
}
```

```shell
GET produce_index/_mapping
```

### Change Mapping Field
__STEP 1: Create a new index(produce_v2) with the latest mapping.__
We removed the "enabled" parameter from the field "botanical_name" and changed its type to "text".

Example:
```shell
PUT produce_v2
{
  "mappings": {
    "properties": {
      "botanical_name": {
        "type": "text"
      },
      "country_of_origin": {
        "type": "text",
        "fields": {
          "keyword": {
            "type": "keyword",
            "ignore_above": 256
          }
        }
      },
      "date_purchased": {
        "type": "date"
      },
      "description": {
        "type": "text"
      },
      "name": {
        "type": "text"
      },
      "organic": {
        "type": "boolean"
      },
      "produce_type": {
        "type": "keyword"
      },
      "quantity": {
        "type": "long"
      },
      "unit_price": {
        "type": "float"
      },
      "vendor_details": {
        "type": "object",
        "enabled": false
      }
    }
  }
}
```

__STEP 2: Reindex the data from the original index(produce_index) to the one you just created(produce_v2).__
```
POST _reindex
{
  "source": {
    "index": "produce_index"
  },
  "dest": {
    "index": "produce_v2"
  }
}
```
