/*
  https://adventofcode.com/2019/day/5
*/

const fs = require("fs");

const getNumbersFromFile = filePath =>
  fs
    .readFileSync(filePath, "utf8")
    .split(",")
    .map(Number);

const getComputerOutput = (intcode, input) => {
  let index = 0;
  let opcode;
  let mode = [0, 0, 0];

  const getAt = paramIndex =>
    mode[paramIndex - 1] == 0
      ? intcode[intcode[index + paramIndex]]
      : intcode[index + paramIndex];

  const setMode = oc => {
    let i = 0;
    while (i <= 2) {
      oc = Math.floor(oc / Math.pow(10, 2 - i));
      mode[i] = oc % 10;
      i++;
    }
  };

  while (index < intcode.length) {
    opcode = intcode[index];
    if (opcode === 3) {
      intcode[intcode[index + 1]] = input;
      index += 2;
    } else if (opcode === 99) {
      index++;
      return intcode[0];
    } else {
      setMode(opcode, mode);
      opcode %= 100;

      n1 = getAt(1);
      n2 = getAt(2);

      if (opcode === 1) {
        intcode[intcode[index + 3]] = n1 + n2;
        index += 4;
      } else if (opcode === 2) {
        intcode[intcode[index + 3]] = n1 * n2;
        index += 4;
      } else if (opcode === 4) {
        console.log(n1);
        index += 2;
      } else if (opcode === 5) {
        if (n1 != 0) index = n2;
        else index += 3;
      } else if (opcode === 6) {
        if (n1 == 0) index = n2;
        else index += 3;
      } else if (opcode === 7) {
        intcode[intcode[index + 3]] = n1 < n2 ? 1 : 0;
        index += 4;
      } else if (opcode === 8) {
        intcode[intcode[index + 3]] = n1 == n2 ? 1 : 0;
        index += 4;
      }
    }
  }
};

const main = () => {
  const intcode = getNumbersFromFile("./input.txt");
  const input = 5;
  const output = getComputerOutput(intcode, input);
  console.log(output);
};

main();
