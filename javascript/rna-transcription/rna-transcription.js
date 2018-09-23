class RnaTranscription {
  constructor() {
    this.rna = { C: 'C', G: 'G', A: 'A', U: 'U' };
  }

  transcribe(nucleotide) {
    switch (nucleotide) {
      case 'G':
        return this.rna.C;
      case 'C':
        return this.rna.G;
      case 'T':
        return this.rna.A;
      case 'A':
        return this.rna.U;

      default:
        throw new Error('Invalid input DNA.');
    }
  }

  toRna(sequence) {
    if (sequence === '') {
      return '';
    }

    return sequence
      .split('')
      .map(letter => this.transcribe(letter))
      .join('');
  }
}

export default RnaTranscription;
