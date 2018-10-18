import sys
import boto3


def verify_unique_version():
    try:
        repo = sys.argv[1]
        version = sys.argv[2]
        ecr_client = boto3.client('ecr')
        r = ecr_client.list_images(
            repositoryName=repo
        )

        for image_id in r.get('imageIds', []):
            if image_id.get('imageTag', '___NONE__') == version:
                print('{}:{} exists'.format(repo, version))
                return False

        print('{}:{} is unique'.format(repo, version))
        return True
    except Exception as wtf:
        print(wtf)
        return False


if __name__ == '__main__':
    if verify_unique_version():
        sys.exit(0)
    else:
        sys.exit(1)
