Partie 1 :

1) il manque la ressource contenant les informations sur le bucket de destination S3 en effet le fichier aws_s3_bucket.summary_destination.tf est absent 
il manque également le fichier Kinesis dataStream qui va avoir des informations sur le fichier en input  

2)

5) la partie user_data va servir dans le cas présent à préparer la VM EC2 pour son utilisation en installant les differents programmes et extentions nécessaires à notre application (ingestion des logs avec dataStream)
6) le role de l'agent kinesis ici est de récuperer les logs et de les mettre dans le bon format et les envoyer à kinesis data stream pour permettre leur ingestion


Partie 2: 
1) la partie ingestion qui correspond à la récupération des données à traiter par notre application nottament dans notre cas les logs générés par le fichier python
le service kinesis dataStream va lire depuis ce producer (on utilise l'agent kinesis java agent pour mettre en forme les logs) les données des logs, et c'est donc ce service qui intervient dans la partie ingestion 
2) la partie stockage qui va correspondre à l'endroit ou seront envoyées les données va faire appel au service S3 pour stocker dans une bucket le stream de destination
et pour la partie transport de données justement nous utilisons le service kinesis firehose qui va entreposer les données dans le bucket. les logs ne sont pas stockés et sont généré par le fichier Python
3) le service utilisé pour la partie transformation est kinesis data analytics c'est ce service qui s'occupe de tranformer les données ingérées via dataStream
et qui va les traiter pour qu'ensuite les mettre dans l'output stream 
4) pour la partie exposition, le résultat de l'application est mis à disposition dans le bucket S3 crée pour l'occasion et est accessible pour une utilisation ultérieure ou bien pour faire des requetes dessus


Partie 3:
1) voici la requete modifiée :
SELECT STREAM ROWTIME as datetime, "response" as status, COUNT(*) AS statusCount FROM "SOURCE_SQL_STREAM_001" where response = '500' and request = 'HTTP', FLOOR(("SOURCE_SQL_STREAM_001" partition by response RANGE INTERVAL '5' MINUTE PRECEDING);  
4)
5) elles arrivent dans un certains délais car il prend les résultats par intervalles dedans comme spécifié dans la window