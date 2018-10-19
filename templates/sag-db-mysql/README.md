<!-- Copyright 2013 - 2018 Software AG, Darmstadt, Germany and/or its licensors

   SPDX-License-Identifier: Apache-2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and

     limitations under the License.                                                  

-->
# Creating webMethods database on MySQL Community Edition

With this template you can create user, database, and webMethods database schemas on MySQL Community Edition.

## Requirements

### Supported Software AG releases

* Command Central 10.3 or higher
* Database Component Configurator 10.3 or higher
* webMethods database schemas for products version 10.3 or higher

### Supported platforms

* All supported Windows and UNIX platforms
* MySQL Community Edition 5.7.23
* Docker Engine 17.09 or higher

## Running as a standalone Composite Template

To install Database Component Configurator 10.3 on the Command Central node with alias `local`, create a database named `webm` and a database user named `webm` with password `webm`, and create database components for Integration Server 10.3 with user `sa` with password `MaNaGe123`:

```bash
sagcc exec templates composite apply sag-db-mysql
  release=10.3 repo.product=products repo.fix=fixes nodes=local
  db.host=mysql db.admin.username=sa db.admin.password=MaNaGe123
  db.name=webm db.username=webm db.password=webm
  db.products=[IS,BPM]
  --sync-job --wait 360
```

## Using for local development and testing on Docker platforms

To use this template for local development you must first launch the Command Central container. From the root folder of this project run:

```bash
docker-compose up -d cc
```
Build a mysql image suitable for webMethods and AgileApps
```bash
docker build templates/sag-db-mysql

Tag the image. This is an example:
```bash
docker tag <image id> daerepository03.eur.ad.sag:4443/design-server/test:mysql-5.7.23
```

To launch mysql:
```bash
docker-compose -f templates/sag-db-mysql/docker-compose.yml up -d mysql

To apply the `sag-db-mysql` template to create a user, database, and database components:

```bash
CC_ENV=mysql ./provisionw sag-db-mysql
...
17      Wed Jul 18 17:42:45 UTC 2018    DONE    DONE
```

To verify that the database components are created successfully:

```bash
docker-compose -f templates/sag-db-mysql/docker-compose.yml run --rm test
...
The expected values were successfully retrieved after 1 call within 4 seconds.
```

You can now use this database for creating instances of webMethods products (Integration Server, My webMethods Server) with the following database connection properties:

```bash
db.url=jdbc:mysql://mysql:3306/webm
db.username=webm
db.password=mysql
db.type=mysqlc
```
