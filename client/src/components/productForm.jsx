import React from "react";

export default class ProductForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();
    var price = this.refs.price.value.trim();
    var name = this.refs.name.value.trim();
    if (!price || !name) {
      return;
    }
    this.props.onProductSubmit({price: price, name: name});
    this.refs.price.value = '';
    this.refs.name.value = '';
  }

  render() {
    return (
      <div className="col-sm-6">
        <form className="productForm" onSubmit={this.handleSubmit}>
          <h3>Add a new product:</h3>
          <div className="form-group">
            <label htmlFor="price">Price</label>
            <input type="text" id="price" ref="price" className="form-control" placeholder="Price"/>
          </div>
          <div className="form-group">
            <label htmlFor="name">Name</label>
            <input type="text" id="name" ref="name" className="form-control" placeholder="Name"/>
          </div>
          <button type="submit" className="btn btn-primary">Add product</button>
        </form>
      </div>
    );
  }
}
