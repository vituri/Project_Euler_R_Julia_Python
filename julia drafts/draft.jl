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

# 5
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
    n = BigInt(600851475143)
    
    possible_primes = sieve_of_eratosthenes(isqrt(n))

    id = findlast(x -> n % x == 0, possible_primes)    
    possible_primes[id]
end;

p5()
@benchmark p5()
