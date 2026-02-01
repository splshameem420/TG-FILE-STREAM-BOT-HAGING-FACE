FROM golang:1.21-alpine3.18 as builder
RUN apk update && apk upgrade && apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/EverythingSuckz/TG-FileStreamBot .
RUN CGO_ENABLED=0 go build -o /app/fsb ./cmd/fsb

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/fsb /app/fsb

# Hugging Face-এর জন্য ডিফল্ট পোর্ট
ENV PORT=7860
# এরর এড়াতে এনভায়রনমেন্ট মুড সেট করা
ENV CONFIG_FILE_PATH="" 

EXPOSE 7860

# সরাসরি কমান্ড রান করা
ENTRYPOINT ["/app/fsb"]
CMD ["run"]