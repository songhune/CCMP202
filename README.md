# CCMP202
영어데이터분석기초-Ajou_Univ

만약 jupyter notebook을 사용해서 이 코드를 동작시켜보고 싶으시다면 이하의 절차대로 실행해 주세요

1. python 3를 받는다(3.6)이상의 버전 아무거나 상관없습니다.(path 추가/pip설치 시켜줘야 됩니다.)
2. zip download를 합니다.
3. 다운받은 경로로 들어가 콘솔(cmd)에서
```python
pip3 install requriments.txt
```
4. R 콘솔에서
```R
install.packages('devtools')
devtools::install_github('IRkernel/IRkernel')
# or devtools::install_local('IRkernel-master.tar.gz')
IRkernel::installspec()  # to register the kernel in the current R installation
```
5. 콘솔(cmd)다운받은 경로로 들어가
jupyter notebook
을 치면 실행됩니다.
