# EC 463 MiniProject
--------------------
## Application Name

Food Scanner v1.1

-------------------
## Team Members
1) Taehyon Paik (U)
 - Back-End development
 - Barcode scanner plugins
 - REST API
 - Firebase Flutter system link
 - Storing API data to DB 
 - get list from DB 

2. Jungin Chang (U07196971)
 - Front-End development
 - Firebase email authentication
 - UI design 
 - Icon / Splash / loading screen
 - Github maintenance
--------------------
## Main Features 
1) Authentication 

Debug/Problem Documentation:

09/13: 
Certain Barcodes don't store in firebase storage.
Can't delete entire collection. Can only delete field in the document.

# ODP 분류 
-------------
## 제공 기능 설명

1) taxonomy 간소화: 데이터 셋을 휴리스틱 룰에 의해 간소화 시킨 후 taxonomy를 구축한다.
2) 텍스트 분류모델 학습: 간소화된 카테고리와 그에 해당하는 문서들은 모두 데이터 전처리 과정을 거친다. 각 카테고리의 내용을 문서당 역빈도 수, 센트로이드, 코사인 유사도를 이용해 수치화 시킨 후 모델링을 시행한다.  
3) 텍스트 분류: input text를 위의 과정을 거처 수치화 시킨다. 모델링을 이용하여 k개의 유사도가 높은 카테고리를 도출한다.
------------
## 사용 예제 

* Input:
텍스트 분류를 실시할 텍스트.
```
"I like to play soccer"
```

* 실행소스: taxonomy에서 input text와 유사도가 높은 k개의 카테고리를 추출한다.
```python
from service.datacrain.odp_classifier.odp_classifier_factory import OdpClassifierFactor
text = "I like to play soccer" 
k = 5
c_ids, c_names, scores = ocf.classify(text, k)
```

* Output: K개의 카테고리 ID, 카테고리 이름, 유사도가 tuple로 이루어져있다.
```
(c_ids, c_names, scores) = ([123382, 123467, 100321, 123372, 123468], ['Top/Sports/Soccer/CONCACAF/Canada', 'Top/Sports/Soccer/CONCACAF/United_States', 'Top/Shopping/Sports/Soccer', 'Top/Sports/Soccer/CONCACAF', 'Top/Sports/Soccer/CONCACAF/United_States/Amateur'], [0.44421496251593173, 0.40367274719874036, 0.4005324910666481, 0.3994548581821958, 0.39398408765122783])
```
------------------
## 모델 학습
* 학습 데이터:
텍스트 분석의 텍소노미 구축을 위한 데이터 셋의 예제는 다음과 같다. 예제는 xml 형식이며, 텍소노미 구축에 필요한 Title, Description, Topic을 이용한다. 학습 데이터 셋의 원본은 https://dmoz-odp.org/ 에 개시되어 있다. 
``` 
    <d:Title>Animation World Network</d:Title>
    <d:Description>Provides information resources to the international animation community. Features include searchable database archives, monthly magazine, web animation guide, the Animation Village, discussion forums and other useful resources.</d:Description>
    <priority>1</priority>
    <topic>Top/Arts/Animation</topic>
``` 

* 실행소스: 구축된 텍소노미를 이용해 카테고리의 가중치 간 센트로이드를 계산하여 모델을 학습시킨다. 
```python
from core.text_analysis.odp_classifier.taxonomy_factory import TaxonomyFactory
from core.text_analysis.odp_classifier.train_factory import TrainFactory

# 1. 텍소노미를 구축한다.
tax_ftr = TaxonomyFactory.instance()
tax_ftr.build_taxonomy()

# 2. 모델 학습
tr_ftr = TrainFactory.instance()
tr_ftr.train()
```
* 저장 위치:
다음은 학습 모델의 저장경로이다. 
```
# ODP 데이터 경로: "core/text_analysis/odp_classifier/train_data/original_odp_dataset.u8"
# Taxonomy 저장경로: "core/text_analysis/odp_classifier/model_data/taxonomy.json"
# tfidf 데이터의 저장경로: "core/text_analysis/odp_classifier/model_data/tfidfv.h5"
# X 데이터의 저장경로: "core/text_analysis/odp_classifier/model_data/X.h5"
# Y 데이터의 저장경로: "core/text_analysis/odp_classifier/model_data/y.h5"
# centroid 모델의 저장경로: "core/text_analysis/odp_classifier/model_data/centroid.h5"
# merge centroid 모델의 저장경로: "core/text_analysis/odp_classifier/model_data/merge_centroid.h5"
```
