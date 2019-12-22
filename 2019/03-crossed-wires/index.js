/*
  https://adventofcode.com/2019/day/3
*/
const fs = require("fs");

const getInputFromFile = filePath => fs.readFileSync(filePath, "utf8");

const getWirePositions = wire => {
  const positions = new Map();
  const position = { x: 0, y: 0 };

  let uid = 0;
  const commands = wire.split(",");
  commands.forEach(command => {
    const direction = command[0];
    const distance = parseInt(command.slice(1));

    for (let i = 0; i < distance; i++) {
      position.x += direction === "L" ? -1 : direction === "R" ? 1 : 0;
      position.y += direction === "U" ? -1 : direction === "D" ? 1 : 0;

      positions.set(`${position.x},${position.y}`, ++uid);
    }
  });

  return positions;
};

const main = () => {
  const wires = getInputFromFile("./input.txt").split("\n");

  const positions1 = getWirePositions(wires[0]);
  const positions2 = [...getWirePositions(wires[1])];

  const intersections = positions2.filter(([position]) => positions1.has(position));
  const distances = intersections.map(([position, steps]) => positions1.get(position) + steps);
  const smallestDistance = distances.sort((a, b) => a - b)[0];

  console.log(smallestDistance);
};

main();
