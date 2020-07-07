# deploy order

Each of these states lays the infrastructure for those state below it.

 - platforms/global
 - platforms/<stage|prod>
 - services/external-dns/<stage|prod>
 - services/meilisearch/<stage|prod>
 - services/podscriber/<stage|prod>
