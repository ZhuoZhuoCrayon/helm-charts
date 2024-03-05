# helm-charts
helm charts repo



```shell
chart_name="crayon-otel-demo"

cd ${chart_name}
helm package src -u -d src/_charts

cd ..
# 同模块 index.yaml 更新
helm repo index ${chart_name}/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/${chart_name}/src/_charts/ --merge ${chart_name}/index.yaml
# 将当前子模块的 index.yaml，更新到主模块
helm repo index ${chart_name}/src/_charts --url https://github.com/ZhuoZhuoCrayon/helm-charts/raw/main/${chart_name}/src/_charts/ --merge index.yaml
```
;;