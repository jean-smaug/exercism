export class InputCell {
  constructor(value) {
    this.value = value;
    this.listeners = [];
  }

  setValue(value) {
    this.value = value;

    this.listeners.forEach((listener) => {
      listener.emit(value);
    });
  }

  subscribe(listener) {
    this.listeners.push(listener);
  }
}

export class ComputeCell {
  constructor(inputCells, fn) {
    this.fn = fn;
    this.value = fn(inputCells);
    inputCells.forEach((inputCell) => {
      inputCell.subscribe(this);
    });
  }

  emit(value) {
    console.log('called', value);
    this.value = this.fn([{ value }]);
  }
}

export class CallbackCell {}
