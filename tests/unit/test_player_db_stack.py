import aws_cdk as core
import aws_cdk.assertions as assertions

from player_db.player_db_stack import PlayerDbStack

# example tests. To run these tests, uncomment this file along with the example
# resource in player_db/player_db_stack.py
def test_player_db_created():
    # create a core app in region us-east-1
    app = core.App()
    stack = PlayerDbStack(app, "player-db", env=core.Environment(account='a123', region='us-east-1'))
    template = assertions.Template.from_stack(stack)
    template.has_resource_properties("AWS::DynamoDB::GlobalTable", {"TableName": "nhl-players-v1"})
