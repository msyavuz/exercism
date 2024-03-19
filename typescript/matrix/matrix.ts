export class Matrix {
  private numberMatrix: number[][] = [];
  private transposed: number[][] = [];
  constructor(stringMatrix: string) {
    const stringRows = stringMatrix.split("\n");

    for (let i = 0; i < stringRows.length; i++) {
      const stringCols = stringRows[i].split(" ");

      const numCols: number[] = [];

      for (let j = 0; j < stringCols.length; j++) {
        numCols.push(Number(stringCols[j]));
      }
      this.numberMatrix.push(numCols);
    }

    this.transposed = this.numberMatrix[0].map((col, i) =>
      this.numberMatrix.map((row) => row[i]),
    );
  }

  get rows(): number[][] {
    return this.numberMatrix;
  }

  get columns(): number[][] {
    return this.transposed;
  }
}
