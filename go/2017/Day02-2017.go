package main

import (
	"fmt"
	"io/ioutil"
	"math"
	"strconv"
	"strings"
)

var numbers [][]int

func Day02() {

	// read the file into a structure
	b, _ := ioutil.ReadFile("../data/day02.data")

	lines := strings.Split(string(b), "\n")

	numbers = make([][]int, len(lines))
	for i := range numbers {
		elements := strings.Split(lines[i], "\t")
		numbers[i] = make([]int, len(elements))
		for j := range elements {
			numbers[i][j], _ = strconv.Atoi(elements[j])
		}
	}

	day02part1()
	day02part2()
}

func day02part1() {
	checksum := 0

	for _, numbersLine := range numbers {
		min := math.MaxInt32
		max := math.MinInt32
		for _, number := range numbersLine {
			if number < min {
				min = number
			}
			if number > max {
				max = number
			}
		}

		checksum += (max - min)
	}

	fmt.Printf("Part 1: %d\n", checksum)
}

func day02part2() {
	checksum := 0

	for _, numbersLine := range numbers {
		for i := 0; i < len(numbersLine); i++ {
			a := numbersLine[i]
			for j := 0; j < len(numbersLine); j++ {
				b := numbersLine[j]

				if a != 0 && b != 0 && a > b && a%b == 0 {
					checksum += a / b
				}
			}
		}
	}

	fmt.Printf("Part 2: %d\n", checksum)
}
