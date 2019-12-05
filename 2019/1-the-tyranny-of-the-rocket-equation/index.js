/*
  https://adventofcode.com/2019/day/1
*/

const fs = require("fs");

const getLinesFromFile = filePath =>
  fs
    .readFileSync(filePath, "utf8")
    .toString()
    .split("\n");

const getFuelNeeded = mass => {
  const fuel = Math.floor(mass / 3) - 2;
  return fuel > 0 ? fuel : 0;
};

const main = () => {
  const masses = getLinesFromFile("./input.txt");

  const totalFuel = masses.reduce((acc, mass) => {
    let totalFuelNeeded = getFuelNeeded(mass);

    let fuelToCompute = totalFuelNeeded;
    while (true) {
      const fuelNeededForFuel = getFuelNeeded(fuelToCompute);
      if (fuelNeededForFuel == 0) break;
      totalFuelNeeded += fuelNeededForFuel;
      fuelToCompute = fuelNeededForFuel;
    }

    return acc + totalFuelNeeded;
  }, 0);

  console.log(totalFuel);
};

main();
