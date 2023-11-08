## 📌 MacOS에서 mysql 설치하기

🌷`brew install mysql` 명령어 입력하기 

> 만약 "Cannot Install In Homebrew On ARM Processor In Intel Default Prefix" 이런 에러가 발생하면 ? 

* `brew config` 
-> 여기서 prefix 확인하기 (위의 에러는 brew를 인텔 버전으로 잘못 설치하여 brew의 prefix가 /usr/local 로 지정되어 있기 때문)
* `/opt/homebrew/bin/brew doctor`
-> 이 명령어를 치면 아래를 입력하라는 문구가 나온다.
* `echo ‘export PATH=”/opt/homebrew/bin:$PATH”’ >> ~/.zshrc`
-> 이렇게 하면 에러가 해결.

> Xcode 설치가 안되어있다면?
* `xcode-select --install` 
-> xcode를 설치해준다. 


## 📌 mysql 실행하기 

🌷`mysql.server start` -> 실행하기

🌷 `mysql -u root -p` -> 접속하기

