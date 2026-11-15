# helm-charts
helm charts repo

## Valkey in common-svrs

Valkey is optional and runs alongside Redis. To enable it, first create a Secret
named `<release>-valkey-auth` in the release namespace with the password under
the `password` key, then add this to your release values:

```yaml
valkey:
  enabled: true
```

For the `common-svrs` release, clients connect to `common-svrs-valkey:6379`
inside the namespace using the `default` ACL user. The standalone instance uses
a ClusterIP Service and a 2 GiB claim on the default StorageClass. Override
`valkey.auth.usersExistingSecret` or `valkey.persistence.storageClass` if needed.



```shell
chart_name="common-svrs"

cd $chart_name
helm package src -u -d src/_charts

cd ..
# 同模块 index.yaml 更新
helm repo index $chart_name/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/$chart_name/src/_charts/ --merge $chart_name/index.yaml
mv $chart_name/src/_charts/index.yaml $chart_name/index.yaml

# 将当前子模块的 index.yaml，更新到主模块
helm repo index $chart_name/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/$chart_name/src/_charts/ --merge index.yaml
mv $chart_name/src/_charts/index.yaml index.yaml
```
