#!/usr/bin/env python3
import os

import aws_cdk as cdk

from player_db.player_db_stack import PlayerDbStack


app = cdk.App()
PlayerDbStack(app, "PlayerDbStack",
              env=cdk.Environment(account=os.getenv('ACCOUNT'), region=os.getenv('REGION')),
            )

app.synth()
