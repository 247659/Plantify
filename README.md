# Plantify

### Poradnik do dockera - wersja dla opornych jak ja

### Ważne
>- -it to tryb interaktywny, gdzie mamy kontrole nad tym co sie wykonuje w kontenerze
>- -d kontener dziala w tle
backend jak chcecie zeby tylko dzialal i nie zamierzacie nic zmieniac, to lepiej -d
frontend zawsze -it, bo flutter nie obsluguje jeszcze automatycznego hot-reloada
>- Zalecam przeczytać przede wszystkim sekcje DOCKER-COMPOSE

### BACKEND
- Wchodzimy w terminal, tworzymy i uruchamiamy kontener:
>mvn clean package
>
>docker build -t plantify-backend .
>
>docker run <-it lub -d> -p 8080:8080 --name plantify-backend-container 
>
>plantify-backend

- Żeby wrócić do kontenera po wyjściu i miec dostęp do basha:
>docker start -i plantify-backend-container
>
>docker exec -it plantify-backend-container bash

### FRONTEND
- Otwieramy terminal (w vscode -> ctrl + shift + ~), cleanujemy projekt, tworzymy kontener i go uruchamiamy:
>flutter clean
>
>docker build -t plantify-frontend .
>
>docker run -it -p 8000:8000 -v ${PWD}/lib:/app/lib --name plantify-frontend-container plantify-frontend

- Żeby wrócić do kontenera po wyjściu i miec dostęp do basha:
>docker start -i plantify-frontend-container
>
>docker exec -it plantify-frontend-container bash

### DOCKER COMPOSE
- Uruchamiamy wraz ze zbudowaniem obrazów (jeśli mamy obrazy to bez --build):
>docker-compose up --build

- Jeśli chcemy na bieżąco nadzorować zmiany w kodzie fluttera i potrzebujemy możliwości reloada to wchodzimy do kontenera:
>docker exec -it plantify-frontend-container bash

- Wyświetlamy procesy i zabijamy proces fluttera, który nam hostuje server na porcie :8000:
>ps aux
>
>kill PID

- Uruchamiamy server na porcie :8000:
>flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8000

- Cieszymy się, bo możemy reloadować

#### Crated by your Chef