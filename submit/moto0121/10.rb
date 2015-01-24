#!/usr/bin/env ruby
# coding: utf-8

a = gets.chomp.to_i

def quicksort(a, left, right)
  return a if left >= right
  
  pivot = a[((left + right).to_f/2.to_f).ceil]
  i = left
  j = right

  while true
    i += 1 while a[i] < pivot
    j -= 1 while a[j] > pivot
    
    break if (i >= j)
    a[i], a[j] = a[j], a[i]
    i += 1
    j -= 1
  end
  quicksort(a, left, i-1)
  quicksort(a, i, right)
  
end

quicksort(a,0,a.size - 1)

p a