FROM instrumentisto/flutter:3.27.3

WORKDIR /app

COPY . .

EXPOSE 8000

ENTRYPOINT ["sh", "-c", "flutter clean && flutter pub get && flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8000 & tail -f /dev/null"]