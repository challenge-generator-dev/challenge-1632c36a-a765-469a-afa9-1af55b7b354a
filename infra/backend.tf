terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "prod/backend.tfstate"
    region = "us-east-1"
    
    # El estudiante debe completar esta configuración
    # con los valores correctos para su entorno
    
    # Opciones de estado remoto:
    # - encrypt: true (cifrado en S3)
    # - dynamodb_table: "terraform-locks" (para bloqueo de estado)
    # - profile: "default" (perfil de AWS credentials)
  }
}