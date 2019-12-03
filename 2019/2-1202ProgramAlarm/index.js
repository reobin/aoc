/*
  https://adventofcode.com/2019/day/2
*/

const fs = require("fs");

const getNumbersFromFile = filePath =>
  fs
    .readFileSync(filePath, "utf8")
    .split(",")
    .map(Number);

const ADD = 1;
const MULTIPLY = 2;
const HALT = 99;

const getComputerOutput = (noun, verb) => {
  const intcode = getNumbersFromFile("./input.txt");

  intcode[1] = noun;
  intcode[2] = verb;

  let index = 0;
  while (index < intcode.length) {
    opcode = intcode[index];
    if (opcode === ADD || opcode === MULTIPLY) {
      const number1 = intcode[intcode[index + 1]];
      const number2 = intcode[intcode[index + 2]];

      const outputPosition = intcode[index + 3];
      intcode[outputPosition] = opcode === ADD ? number1 + number2 : number1 * number2;

      index += 4;
    } else if (opcode === HALT) break;
  }
  return intcode;
};

const findAttributesForTarget = target => {
  for (let noun = 0; noun <= 99; noun++) {
    for (let verb = 0; verb <= 99; verb++) {
      const [indexZero, _] = getComputerOutput(noun, verb);
      if (indexZero === target) return { noun, verb };
    }
  }
};

const main = () => {
  const target = 19690720;
  const { noun, verb } = findAttributesForTarget(target);
  console.log(noun, verb);
};

main();
