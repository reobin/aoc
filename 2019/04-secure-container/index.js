const MINIMUM = 382345;
const MAXIMUM = 843167;

const hasDouble = password => {
  const checkedChars = [];

  for (let i = 0; i < password.length; i++) {
    const char = password[i];
    if (!checkedChars.includes(char)) {
      const occurences = password.split(char).length - 1;

      if (occurences === 2) return true;
      else checkedChars.push(char);
    }
  }

  return false;
};

const isIncreasing = value => {
  const numberArray = value.split("").map(Number);
  const sortedArray = [...numberArray].sort((a, b) => a - b);
  return numberArray.every((number, index) => number === sortedArray[index]);
};

const isPasswordValid = password => {
  try {
    if (password.length !== 6) return false;

    if (!hasDouble(password)) return false;

    if (!isIncreasing(password)) return false;

    const num = Number(password);
    if (num < MINIMUM || num > MAXIMUM) return false;

    return true;
  } catch (e) {
    console.error(e);
    return false;
  }
};

const countValidPasswords = () => {
  let counter = 0;
  for (let i = MINIMUM; i <= MAXIMUM; i++) {
    const password = i.toString();
    if (isPasswordValid(password)) counter++;
  }
  return counter;
};

const main = () => console.log(countValidPasswords());

main();
