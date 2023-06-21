using BenchmarkTools;

# 1
function p1()
    [x for x ∈ 1:1000 if (x % 3 == 0 || x % 5 == 0)] |> sum
end
@benchmark p1()

# 2 
function p2()
    fibo = [1, 2]
    while true
        current_fibo_term = fibo[end] + fibo[end - 1]
        if current_fibo_term < 4_000_000
            push!(fibo, current_fibo_term)
        else 
            break
        end        
    end
    
    return [x for x ∈ fibo if iseven(x)] |> sum

end;
p2()

@benchmark p2()
n = 1000

# 3
function sieve_of_eratosthenes(n::Integer)
    sieve = trues(n)  # Create a boolean array to mark primes

    # Set the multiples of primes as false (not prime)
    for i in 2:isqrt(n)
        if sieve[i]
            for j in i^2:i:n
                sieve[j] = false
            end
        end
    end

    primes = filter(x -> sieve[x], 2:n)  # Filter out non-primes

    return primes
end

function p5()
    n = 600851475143
    
    possible_primes = sieve_of_eratosthenes(isqrt(n))

    id = findlast(x -> n % x == 0, possible_primes)    
    possible_primes[id]
end;

p5()
@benchmark p5()
@btime p5()

# 8
function p8()
    big_string = "73167176531330624919225119674426574742355349194934
    96983520312774506326239578318016984801869478851843
    85861560789112949495459501737958331952853208805511
    12540698747158523863050715693290963295227443043557
    66896648950445244523161731856403098711121722383113
    62229893423380308135336276614282806444486645238749
    30358907296290491560440772390713810515859307960866
    70172427121883998797908792274921901699720888093776
    65727333001053367881220235421809751254540594752243
    52584907711670556013604839586446706324415722155397
    53697817977846174064955149290862569321978468622482
    83972241375657056057490261407972968652414535100474
    82166370484403199890008895243450658541227588666881
    16427171479924442928230863465674813919123162824586
    17866458359124566529476545682848912883142607690042
    24219022671055626321111109370544217506941658960408
    07198403850962455444362981230987879927244284909188
    84580156166097919133875499200524063689912560717606
    05886116467109405077541002256983155200055935729725
    71636269561882670428252483600823257530420752963450" |>
        filter(isnumeric) # keep only numeric characters
    
    biggest_product = 0
    winner_string = ""
    amount_of_digits = 13
    
    for i in (amount_of_digits + 1):length(big_string)
        current_string = collect(big_string[i-amount_of_digits : i])
        
        p = map(x -> parse(Int32, x), current_string) |> prod
        if p > biggest_product
            biggest_product = p
            winner_string = current_string
        end
    end
    
    return winner_string, biggest_product
  end;
  
  a, b = p8()

reduce(*, a)
