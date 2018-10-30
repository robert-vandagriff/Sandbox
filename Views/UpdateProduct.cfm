<cfparam name="Action" type="[string]" default="[]">
<cfquery name="AddUpdateProduct" datasource="TBD" result="cfResult">
    IF #Form.Action# = 'Edit'
        UPDATE Products 
        SET
            ProductNumber = #Form.ProductNumber#,
            ProductName = #Form.ProductName#,
            ProductDescription = #Form.ProductDescription#,
            ProductCategory = #Form.ProductCategory#,
            ProductStandardCost = #Form.ProductStandardCost#
        WHERE ProductId = #Form.ProductId#
    ELSE IF #Form.Action# = 'Add'
        INSERT INTO Products (ProductNumber,ProductName,ProductDescription,ProductCategory,ProductStandardCost)
        VALUES
         (#Form.ProductNumber#,#Form.ProductName#,#Form.ProductDescription#,#Form.ProductCategory#,#Form.ProductStandardCost#)
    ELSE
        --Do Nothing
</cfquery>
<div id="AddEditConfirmation">
    <cfif #cfResult# = 1>
        <span>Product successfully 
        <cfif #Form.Action# = "Edit">
        updated!
        <cfelse #Form.Action# = "Add">
        added!
        </cfif>
        </span>
    <cfelse #cfResult# = 0>
        <span>Action failed, please contact customer support.</span>
    </cfif>
</div>
<script>
    $(document).ready(function() {
        var result = #cfResult#;
        if (result){
            var msg = document.getElementById('AddEditConfirmation');
            msg.style.display = "block"; 
        }
    });
</script>