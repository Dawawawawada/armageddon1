


# Example Usage - Life cycle settings for storage bucket objects
#BLOCK     #RESOURCE TYPE        #RESOURCE NAME
resource "google_storage_bucket" "maymadnessmantis-1a" {
  name          = "mantismayhem-1a"
  storage_class =  "STANDARD"
  location      = "us-central1"
  force_destroy = true
  labels = {
    environment = "theosclassroom"
    "dep" = "tryingnottogetkickedout"
  }
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
  
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  
  }

}
resource "google_storage_bucket_object" "photo-1" {
bucket = google_storage_bucket.maymadnessmantis-1a.name
name = "index.html"
source = "index.html"
content_type = "text/html"
}

resource "google_storage_bucket_object" "photo-2" {
name = "p1023588.jpg" 
source = "p1023588.jpg"
bucket = google_storage_bucket.maymadnessmantis-1a.name

}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.maymadnessmantis-1a.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}