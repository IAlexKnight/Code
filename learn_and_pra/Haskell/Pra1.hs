succ_num = succ (9 * 10) `div` 9

cons_string = 'A' : "SMALL CAT" ++ "!"
conpare_list = [3,2,1] > [2,1,3,4]
the_tail = tail cons_string
the_head = head cons_string
the_last = last cons_string
the_init = init (reverse  cons_string)
the_length = length cons_string
after_drop = drop 2 cons_string
infinite = take 10 [13,26..]

the_sum = sum infinite
the_product = product infinite
the_elem = elem 39 infinite
mod7 = [x | x <- infinite, x `mod` 7 == 0, x /= 91]

length' xs = sum[1 | _ <- xs]

the_repeat = take 10 (repeat 5)
the_cycle = take 10 (cycle [1,2,3])
the_replicate = replicate 3 10
tuples = [(1,'a'), (2, 'b'), (3, 'c')]
list_of_list = [the_repeat, the_cycle, the_replicate]
xxs = [ [x | x <- xs, even x] | xs <- list_of_list]

the_cadr = (fst (1,2),snd(1,2))
the_zip = zip the_repeat the_cycle












