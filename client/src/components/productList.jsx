import React from "react";
import Product from "./product";

export default class ProductList extends React.Component {
  render() {
    let products = this.props.products.map((product) => {
      return (
        <Product product={product} key={product._id.$oid} onProductDelete={this.props.onProductDelete}/>
      );
    });

    return (
      <div className="productList col-sm-6">
        {products}
      </div>
    );
  }
}
