import boto3
import datetime

s3 = boto3.client('s3',
    endpoint_url='https://s3.us-central-1.wasabisys.com',
    aws_access_key_id='IQ6A1J5AQS4JBX3ZVQ36',
    aws_secret_access_key='fOBklqf2J9NeMOB3YEnzqWpplcBB0u9XSwDnCawg'
)

url = s3.generate_presigned_url(
    'put_object',
    Params={'Bucket': 'n8n-objects', 'Key': 'final-videos/final_output.mp4'},
    ExpiresIn=3600
)

print(url)

