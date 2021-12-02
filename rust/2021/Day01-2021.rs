use std::path::Path;
use std::io::prelude::*;
use std::fs::File;

fn main() {
    
    let path = Path::new("../../data/2021/day01.data");
    let mut file = match File::open(&path) {
        Err(why) => panic!("couldn't open {}: {}", path.display(), why),
        Ok(file) => file,
    };

    let mut s = String::new();
    match file.read_to_string(&mut s) {
        Err(why) => panic!("Couldn't read {}: {}", path.display(), why), 
        Ok(_) => (), 
    }

    let mut numbers = Vec::new();
    for number in s.lines() {
        numbers.push(number.parse::<u32>().unwrap())
    }

    part1(&numbers);
    part2(&numbers);
}

fn part1(numbers: &Vec<u32>) {
    let mut total = 0;

    for i in 1 .. numbers.len() {
        if numbers[i] > numbers[i - 1] {
            total += 1;
        }
    }

    println!("{}", total);
}

fn part2(numbers: &Vec<u32>) {
    let window_size = 3;

    let mut total = 0;

    let mut previous = 0;
    for i in 0 .. window_size {
        previous += numbers[i];
    }

    for i in 1 ..= numbers.len() - window_size {

        let mut current = 0;
        for j in i .. i + window_size {
            current += numbers[j];
        }

        if current > previous {
            total += 1;
        }

        previous = current;

    }

    println!("{}", total);
}