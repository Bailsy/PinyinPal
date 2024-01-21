<?php 

  //MySQL database Connection
  $con=mysqli_connect('mydatabase.cr8csc4s4i51.eu-north-1.rds.amazonaws.com:3306','admin','stbeesschool','accounts');
  
  //Received JSON into $json variable
  $json = file_get_contents('php://input');
  
  //Decoding the received JSON and store into $obj variable.
  $obj = json_decode($json,true);
  
  if(isset($obj["email"]) && isset($obj["username"]) && isset($obj["password"])){
    $email = mysqli_real_escape_string($con,$obj['email']);
    $uname = mysqli_real_escape_string($con,$obj['username']);
    $pwd = mysqli_real_escape_string($con,$obj['password']);
    
    //Declare array variable
    $result=[];
    $hashedPassword = password_hash($pwd, PASSWORD_DEFAULT);
    
    //Insert User Data Query
    $userInsertQuery = "INSERT INTO users (UNAME, UPASS) VALUES ('$uname', '$hashedPassword')";
    
    $userResult== mysqli_query($con, $userInsertQuery);
    
    // Check if user insertion was successful
    if ($userResult) {
        // Get the UID of the inserted user
        $uid = mysqli_insert_id($con);

        // Set default values for the "profiles" table
        $email = ""; // You might want to capture the email separately in the sign-up form
        $usertype = "new";
        $xp = 0;
        $profilepic = 'https://pinyinpal.com/panda.png';

        // Insert into "profiles" table
        $profileInsertQuery = "INSERT INTO profiles (UID, EMAIL, USERTYPE, XP, PROFILEPIC) VALUES ('$uid', '$email', '$usertype', '$xp', '$profilepic')";
        $profileResult = mysqli_query($con, $profileInsertQuery);

        // Check if profile insertion was successful
        if ($profileResult) {
            $response['signupStatus'] = true;
            $response['message'] = 'Sign-up successful';
        } else {
            // Rollback the user insertion if profile insertion fails
            mysqli_query($con, "DELETE FROM users WHERE UID = '$uid'");

            $response['signupStatus'] = false;
            $response['message'] = 'Error inserting into profiles table';
        }
    } else {
        $response['signupStatus'] = false;
        $response['message'] = 'Error inserting into users table';
    }

    echo json_encode($response);
} else {
    // Invalid request method
    http_response_code(405);
    echo json_encode(['error' => 'Invalid request method']);
}
?>