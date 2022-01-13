using DataStructures

input = readlines("day04-input.txt")

#= input = [
"aaaaa-bbb-z-y-x-123[abxyz]",
"a-b-c-d-e-f-g-h-987[abcde]",
"not-a-real-room-404[oarel]",
"totally-real-room-200[decoy]",
] =#

function parse_room(room)
    
    checksum_regex = r"\[[a-z]{5}\]"
    sector_regex = r"[0-9]{3}"
    
    checksum = match(checksum_regex, room).match
    sector = match(sector_regex, room).match
    
    room = replace(room, checksum => "")
    room = replace(room, sector => "")
    room = replace(room, r"\-" => "")
    
    checksum = replace(checksum, r"\[|\]" => "")
    return [room, checksum, sector]
end

function do_checksum(room)
    
    letter_count = collect(counter(room))
    
    sort!(letter_count, by = x-> x[1])    # Sort alphabetically first
    sort!(letter_count, by = x->-x[2])    # Then sort by count
    
    checksum = String(collect(x[1] for x in letter_count[1:5]))
    return checksum
end

real_rooms = Int[]

for line in input
    room, checksum, sector = parse_room(line)
    if checksum == do_checksum(room)
        push!(real_rooms, parse(Int, sector))
    end
end

print(sum(real_rooms))


# Part 2 ----------------------

function letter_to_number(l)
    l = Char(only(lowercase(l)))  # Convert to a lower case character
    d = Dict(letter => number for (letter, number) in zip("abcdefghijklmnopqrstuvwxyz", 1:26))
    return d[l]
end

function number_to_letter(n)
    n = mod(n - 1, 26) + 1
    d = Dict(number => letter for (letter, number) in zip("abcdefghijklmnopqrstuvwxyz", 1:26))
    return d[n]
end

function shift_string(string, shift)
    word = Char[]
    shift = parse(Int, shift)
    for letter in string
        if letter == '-'
            push!(word, ' ')
        else
            push!(word, number_to_letter(letter_to_number(letter) + shift))
        end
    end
    return(String(word))
end

for line in input
    room, checksum, sector = parse_room(line)
    if checksum != do_checksum(room)
        continue
    end
    out = shift_string(room, sector)

    if occursin(r"north", out)
        print(out, "\n")
        print(sector, "\n")
    end
end

