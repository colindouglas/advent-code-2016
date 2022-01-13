using MD5

input = readline("day05-input.txt")
door_id = input

function hash_door(door_id, int_)
    hash_input = door_id * string(int_)
    return bytes2hex(md5(hash_input))
end

password = Char[]
for i in 0:1000000000
    hash = hash_door(door_id, i)
    if hash[1:5] == "00000"
        push!(password, hash[6])
    end
    if length(password) == 8
        break
    end
end

print("Part 1: ", reduce(*, password), '\n')

# Part 2 ----

function insert_if_possible(password, hash)
    
    # Only insert if the first five chars are 00000
    if hash[1:5] != "00000"
        return password
    end
    
    # If the position character is a letter, don't insert
    if isletter(hash[6])
        return password
    end

    # Now it's safe to parse the insert position
    insert_position = parse(Int, hash[6])
    insert_char = hash[7]

    # If the position character is more than 7, don't insert
    if insert_position > 7
        return password
    end

    if ismissing(password[insert_position + 1])
        password[insert_position + 1] = insert_char
        return password
    else
        return password
    end
end
    
global password = Missings.missings(Char, 8)

for i in 0:1000000000
    hash = hash_door(door_id, i)
    global password = insert_if_possible(password, hash)
    if all(map(!ismissing, password))
        break
    end
end

print("Part 2: ", reduce(*, password), '\n')