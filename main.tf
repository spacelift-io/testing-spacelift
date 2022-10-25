resource "random_string" "test" {
  length = 15
}

resource "time_offset" "offset" {
  offset_days = 7
}

moved {
  from = time_offset.example
  to   = time_offset.offset
}
