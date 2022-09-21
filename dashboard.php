<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>
   <h1>Dashboard</h1> 
   <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Blanditiis iste aliquid assumenda ipsa quae magni.</p>
   <button class="btn logout">Logout</button>

   <script>
       fetch('/backend/login.php')
       .then(res=>res.json())
       .then(data=>{
           if(data.status !=='success')
            window.location.replace('/frontend/index.html');
       });

       const logout = document.querySelector('.logout');
       logout.addEventListener('click', ()=>{
       
        fetch('/backend/login.php?' + new URLSearchParams({logout:true}))
       
       .then(res=>res.json())
       .then(data=>{
           console.log(data);
           if(data.status ==='success')
            window.location.replace('/frontend/index.html');
       });
 
       });

   </script>
</body>
</html>