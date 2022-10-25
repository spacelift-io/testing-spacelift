resource "random_string" "test" {
  length = 15
}

resource "time_offset" "example" {
  offset_days = 7
}
