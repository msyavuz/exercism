type Planet =
  | "mercury"
  | "venus"
  | "earth"
  | "mars"
  | "jupiter"
  | "saturn"
  | "uranus"
  | "neptune";

export function age(planet: Planet, seconds: number): number {
  let age: number;
  switch (planet) {
    case "mercury":
      age = seconds / 31557600 / 0.2408467;
      break;
    case "venus":
      age = seconds / 31557600 / 0.61519726;
      break;
    case "earth":
      age = seconds / 31557600;
      break;
    case "mars":
      age = seconds / 31557600 / 1.8808158;
      break;
    case "jupiter":
      age = seconds / 31557600 / 11.862615;
      break;
    case "saturn":
      age = seconds / 31557600 / 29.447498;
      break;
    case "uranus":
      age = seconds / 31557600 / 84.016846;
      break;
    case "neptune":
      age = seconds / 31557600 / 164.79132;
      break;
  }
  return Number(age.toFixed(2));
}
