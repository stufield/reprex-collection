library(readr)
packageVersion("readr")
txt <- "\t\t\tTarget\t5'-thymine\n\t\t\tNew\tUnknown"  # note the single quote (5')
read_lines(txt)                        # works as expected
read_lines(txt, n_max = 1)             # works as expected
read_lines(txt, n_max = 1, skip = 0)   # works as expected
read_lines(txt, n_max = 1, skip = 1)   # unexpected empty character(0)
txt <- "\t\t\tTarget\t5'-'thymine\n\t\t\tNew\tUnknown"  # note closing quote
read_lines(txt, n_max = 1, skip = 1)   # works as expected
