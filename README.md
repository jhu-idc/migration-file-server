# Migration File Server

Provides assets for migration tests over HTTP; used by the Drupal migration tests.

The sole puropse of this container is to keep "heavyweight" binary objects used for migration tests out of the drupal image.  The [migration test script](https://github.com/jhu-idc/idc-isle-dc/blob/development/tests/10-migration-backend-tests.sh) launches this container, and individual tests (especially those that require media) download the assets using HTTP as needed.  

Because the container is only used by tests, it does not need to be exposed or published to the host, but if you are curious, you can start the container (publishing port 80) and viewing the contents at `http://localhost:<published port>/assets/`:

```
  ext_assets_port=8081
  assets_repo=ghcr.io/jhu-sheridan-libraries/idc-isle-dc
  assets_image=migration-assets
  assets_image_tag=latest
  docker run --name migration-assets --network gateway --rm -d -p ${ext_assets_port}:80 ${assets_repo}/${assets_image}:${assets_image_tag}
```

# Image creation

* `make` will make the Docker image `ghcr.io/jhu-sheridan-libraries/idc-isle-dc/migration-assets`
* `make push` will push the image to GHCR