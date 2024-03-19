export function toRna(dna: string) {
  const translation: Record<string, string> = {
    G: "C",
    C: "G",
    T: "A",
    A: "U",
  };

  if (!/^[G,C,T,A]+$/.test(dna)) {
    throw new Error("Invalid input DNA.");
  }

  return dna
    .split("")
    .map((nuc) => translation[nuc])
    .join("");
}
