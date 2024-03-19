const COLORS = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
];

export function decodedResistorValue(colors: string[]) {
  let prefix = "";

  let zeros = 0;

  if (colors[1] === "black") {
    zeros += 1;
  }

  zeros += COLORS.indexOf(colors[2]);

  let ohmValue =
    (COLORS.indexOf(colors[0]) * 10 + COLORS.indexOf(colors[1])) *
    Math.pow(10, COLORS.indexOf(colors[2]));

  if (zeros >= 9) {
    prefix = "giga";
    ohmValue = ohmValue / Math.pow(10, 9);
  } else if (zeros >= 6) {
    prefix = "mega";
    ohmValue = ohmValue / Math.pow(10, 6);
  } else if (zeros >= 3) {
    prefix = "kilo";
    ohmValue = ohmValue / Math.pow(10, 3);
  }

  return `${ohmValue} ${prefix}ohms`;
}
