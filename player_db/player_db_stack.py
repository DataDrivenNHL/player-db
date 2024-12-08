from aws_cdk import (
    Stack,
    aws_dynamodb as dynamodb,
)

import aws_cdk as cdk

from constructs import Construct

class PlayerDbStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)


        # create a dynamo db table called nhl-players-v1 with a partition key of player_id and a GSI of player_name and team_name
        self.table = dynamodb.TableV2(
            self, "GlobalTable",
            partition_key=dynamodb.Attribute(
                name="player_id",
                type=dynamodb.AttributeType.STRING
            ),
            removal_policy=cdk.RemovalPolicy.DESTROY,
            replicas=[dynamodb.ReplicaTableProps(region="us-west-2")],
            table_name="nhl-players-v1",
            global_secondary_indexes=[
                dynamodb.GlobalSecondaryIndexPropsV2(
                    index_name="player_and_team_name",
                    partition_key=dynamodb.Attribute(
                        name="player_name",
                        type=dynamodb.AttributeType.STRING
                    ),
                    sort_key=dynamodb.Attribute(
                        name="team_name",
                        type=dynamodb.AttributeType.STRING
                    ),
                    projection_type=dynamodb.ProjectionType.ALL,
                )
            ]
        )