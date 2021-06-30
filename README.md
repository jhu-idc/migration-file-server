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

The image tag will be based on the `HEAD` commit hash and the timestamp.  The `Makefile` recipe for the `init` target records the commit hash and timestamp so all subsequent commands (like push) use the same image tag.  The `make clean` command will remove this state.  Invoking `make push` (or `make image` for that matter) multiple times in a row are idempotent until a `make clean` is run.

* `make image` (the default when invoking `make`) will make the Docker image `ghcr.io/jhu-sheridan-libraries/idc-isle-dc/migration-assets` tagged after the `HEAD` commit hash and timestamp
* `make push` will push the image to GHCR
* `make init` establishes the `HEAD` commit hash and timestamp, and is invoked automatically when `image` or `push` is invoked
* `make clean` removes Make state including the image tag being used by `image` and `push`

# GIT LFS

Note that this repository uses [GIT LFS](https://git-lfs.github.com/), which needs to be installed locally using `git lfs install`. Any files added under `assets/lfs` will automatically use LFS; your git workflow does not change at all.

To add additional paths or files to LFS, use `git lfs track`.


