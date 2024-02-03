# helm-charts
helm charts repo



```shell
helm package src -u -d src/_charts
# 同模块 index.yaml 更新
helm repo index common-svrs/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/common-svrs/src/_charts/ --merge common-svrs/index.yaml
# 将当前子模块的 index.yaml，更新到主模块
helm repo index common-svrs/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/common-svrs/src/_charts/ --merge index.yaml
```
