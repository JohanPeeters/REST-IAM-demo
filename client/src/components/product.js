import React from "react";
import {Link} from "react-router";

export default class Product extends React.Component {
  render() {
    const {product} = this.props;
    return (
      <div className="product">
        <h3>{product.name}</h3>
        <span className="lead">
          <Link to={`/products/${product._id.$oid}`}>{product.name}</Link>
        </span>
        <button className="btn btn-xs btn-danger pull-right" onClick={()=>this.props.onProductDelete(product)}>Delete Product</button>
        <hr/>
      </div>
    );
  }
}
